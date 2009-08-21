class UserController < ApplicationController
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome on board, #{@user.name}!"
      redirect_to :controller => 'user', :action => 'profile', :name => @me.name
    else
      render :action => "signup"
    end
  end
  
  
  def profile

    @user = User.find_by_name(params[:name])

    # Restore the users access token from the database and connect to SoundCloud
    access_token = OAuth::AccessToken.new($sc_consumer, @user.soundcloud_account.oauth_token, @user.soundcloud_account.oauth_token_secret)
    sc = Soundcloud.register({:access_token => access_token, :site => "http://api.#{$sc_host}"})

  
    @me = sc.User.find_me
    

    # Look for the latest track of the user
    begin
      @tracks = @me.tracks[0..4]
    rescue
      @tracks = []
    end
    
  end
end
