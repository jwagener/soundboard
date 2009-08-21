class AuthController < ApplicationController
  def login
    if request.post?
      if @me = User.authenticate(params[:name], params[:password])
        session[:user_id] = @me.id

        redirect_to :controller => 'user', :action => 'profile', :name => @me.name
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
