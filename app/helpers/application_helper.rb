# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def login_path
    '/login'
  end
  
  def logout_path
    '/logout'
  end
  
  def register_user_path
    '/register'
  end
end
