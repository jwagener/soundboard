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
  end

end
