class UserController < ApplicationController
  def signup
    @user = User.new
  end
  
  def create
    @user = @current_user = User.new(params[:user])
    if @current_user.save
      session[:user_id] = @current_user.id
      flash[:notice] = "Welcome on board, #{@current_user.name}!"
      redirect_to :controller => 'user', :action => 'profile', :name => @current_user.name
    else
      render :action => "signup"
    end
  end
  
  def update
    p params[:user]
    @current_user.update_attributes!(params[:user])
    redirect_to :controller => 'user', :action => 'profile', :name => @current_user.name
  end
  
  def profile
    @user = User.find_by_name(params[:name])

    # Restore the users access token from the database and connect to SoundCloud
    if @user.soundcloud_account
      access_token = OAuth::AccessToken.new($sc_consumer, @user.soundcloud_account.oauth_token, @user.soundcloud_account.oauth_token_secret)
      sc = Soundcloud.register({:access_token => access_token, :site => "http://api.#{$sc_host}"})
      @me = sc.User.find_me
    end
  end
end
