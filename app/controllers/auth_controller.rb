class AuthController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || {:controller => 'home', :action => 'index'})
      else
        flash.now[:notice] = "Invalid user / password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => 'home')
  end

  def soundcloud  
    request_token = $sc_consumer.get_request_token
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    callback_url = url_for :action => :callback
    authorize_url = "http://api.sandbox-soundcloud.com/oauth/authorize?oauth_token=#{request_token.token}&oauth_callback=#{callback_url}"

    redirect_to authorize_url
  end
  
  def callback
    request_token = OAuth::RequestToken.new($sc_consumer, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token
    
    sc = Soundcloud.register({:access_token => access_token, :site => 'http://api.sandbox-soundcloud.com'})
    
    me = sc.User.find_me

    user = User.find(session[:user_id])
    if user
      user.sc_user_id = me.id
      user.sc_access_token = access_token.token
      user.sc_access_token_secret = access_token.secret
      user.save!
    end
    
    redirect_to :controller => :home
  end
end
