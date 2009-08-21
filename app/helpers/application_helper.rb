# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def login_path
    '/login'
  end
  
  def logout_path
    '/logout'
  end
  
  def signup_user_path
    '/signup'
  end
  
  def home_path
    {:controller => 'home', :action => 'index'}
  end
  
  def users_path
    {:controller => 'home', :action => 'index'}
  end
  
  def users_dashboard_path
    {:controller => 'home', :action => 'dashboard'}
  end
end
