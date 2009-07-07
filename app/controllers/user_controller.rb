class UserController < ApplicationController
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome on board, #{@user.name}!"
      redirect_to :controller => 'home', :action => 'dashboard'
    else
      render :action => "signup"
    end
  end
end
