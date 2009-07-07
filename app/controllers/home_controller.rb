class HomeController < ApplicationController
  require 'rubygems'
  gem 'soundcloud-ruby-api-wrapper'
  require 'soundcloud'

  gem 'oauth'
  require 'oauth'
  
  # Connect "anonymously" (without the access token) to SoundCloud and
  # get the hotest tracks that are streamable. This way you can get public
  # data without authenticating as a user first.
  def index
    sc = Soundcloud.register({:site => 'http://api.sandbox-soundcloud.com'})
    @hot_tracks = sc.Track.find(:all, :params => {"filter" => "streamable", "order" => "hotness"} )
  end

  def dashboard
    if not session[:user_id]
      redirect_to :controller => :home, :action => :index
    end

    @user = User.find(session[:user_id])

    # Restore the users access token from the database and connect to SoundCloud
    access_token = OAuth::AccessToken.new($sc_consumer, @user.sc_access_token, @user.sc_access_token_secret)
    sc = Soundcloud.register({:access_token => access_token, :site => 'http://api.sandbox-soundcloud.com'})

    # See if the request works.
    # If it fails, the user revoked access to his account in the
    # SoundCloud settings and we can trash the access token.
    begin
      @me = sc.User.find_me
    rescue
      @me = nil

      if @user
        @user.sc_user_id = nil
        @user.sc_access_token = nil
        @user.sc_access_token_secret = nil
        @user.save!
      end
    end

    # Look for the latest track of the user
    begin
      @track = @me.tracks.first
    rescue
      @track = nil
    end
  end
end
