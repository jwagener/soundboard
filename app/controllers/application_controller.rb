# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize, :except => [:login, :index, :signup]
  before_filter :loggedoutonly, :only => [:login, :signup]
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_uri] = request.request_uri
      flash[:notice] = "Please log in first"
      redirect_to('/login')
    end
  end
  
  def loggedoutonly
    if session[:user_id]
      redirect_to(:controller => 'home')
    end
  end
end
