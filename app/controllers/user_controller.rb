class UserController < ApplicationController
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      flash[:notice] = "User #{@user.name} was successfully created."
      redirect_to(:action=>'profile', :id => @user)
    else
      render :action => "signup"
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  def settings
    if Integer(session[:user_id]) != Integer(params[:id])
      flash[:notice] = "You're not allowed to see other members' settings!"
      redirect_to(:action => 'settings', :id => session[:user_id])
    else
      @user = User.find(session[:user_id])
    end
  end
  
  def connect
    
  end
end
