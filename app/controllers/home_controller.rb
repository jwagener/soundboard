class HomeController < ApplicationController
  require 'rubygems'
  gem 'soundcloud-ruby-api-wrapper'
  require 'soundcloud'

  gem 'oauth'
  require 'oauth'
  
  def index
    if session[:user_id]
      redirect_to :action => :dashboard
    end
    
    sc = Soundcloud.register({:site => 'http://api.sandbox-soundcloud.com'})
    @hot_tracks = sc.Track.find(:all, :params => {"filter" => "streamable", "order" => "hotness"} )
  end
  
  def dashboard
    if not session[:user_id]
      redirect_to :action => :index
    end
    
    @user = User.find(session[:user_id])
      
    access_token = OAuth::AccessToken.new($sc_consumer, @user.sc_access_token, @user.sc_access_token_secret)
    sc = Soundcloud.register({:access_token => access_token, :site => 'http://api.sandbox-soundcloud.com'})
    
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
    
    begin
      @track = @me.tracks.first
    rescue
      @track = nil
    end
  end

end
