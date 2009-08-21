class AuthController < ApplicationController
  def login
    if request.post?
      if @current_user = User.authenticate(params[:name], params[:password])
        session[:user_id] = @current_user.id

        redirect_to :controller => 'user', :action => 'profile', :name => @current_user.name
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
