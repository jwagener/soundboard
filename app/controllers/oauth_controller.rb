class OauthController < ApplicationController

  # This will get a oauth request token from Soundcloud and 
  # then redirect the user to the Soundcloud authorization page.
  # It stores request token and secret in the session to
  # remember it, when it returns to our defined callback page.
  def request_token
    request_token = $sc_consumer.get_request_token
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    callback_url = url_for :action => :access_token
    authorize_url = "http://#{$sc_host}/oauth/authorize?oauth_token=#{request_token.token}&oauth_callback=#{callback_url}&display=popup"

    redirect_to authorize_url
  end
  
  # After authentication at the Soundcloud authorization page,
  # the user will be redirected to this page.
  # We get the access_token and use it to get the Soundcloud user resource
  # and save the user's information in our database before
  # we redirect him to his dashboard.
  def access_token
    request_token = OAuth::RequestToken.new($sc_consumer, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token
    
    sc = Soundcloud.register({:access_token => access_token, :site => "http://api.#{$sc_host}"})
    me = sc.User.find_me
    sc_account = SoundcloudAccount.create :username => me.username, :oauth_token => access_token.token, :oauth_token_secret => access_token.secret
  
    redirect_to  "/sc-connect/close.html?username=#{CGI::escape(sc_account.username)}&soundcloud_account_id=#{sc_account.id}"
  end  
end