# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

gem 'soundcloud-ruby-api-wrapper'
require 'soundcloud'

class ApplicationController < ActionController::Base
  before_filter :set_current_user
  before_filter :authorize, :except => [:login, :index, :signup, :profile]
  before_filter :loggedoutonly, :only => [:login, :signup]
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

protected
  def set_current_user
   @current_user =  User.find_by_id(session[:user_id])
  end
  
  def authorize
    unless @current_user
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in first"
    end
  end
  
  def loggedoutonly
    if session[:user_id]
      redirect_to(:controller => 'home')
    end
  end
end
