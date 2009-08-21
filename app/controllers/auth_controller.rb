class AuthController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        //uri = session[:original_uri]
        //session[:original_uri] = nil
        redirect_to  {:controller => 'home', :action => 'dashboard'}
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

end
