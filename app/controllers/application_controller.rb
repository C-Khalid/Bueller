class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  before_filter :require_login
  
  include SessionsHelper

  def current_user
    @current_user ||= Student.find(session[:user_id]) if session[:user_id]
  end

   def self.authenticate_with_salt(id, cookie_salt)
     
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    def require_login
      unless current_user  
        redirect_to signup_path
      end
    end
  
    def user_from_remember_token
      Student.authenticate_with_salt(*remember_token)
    end

    def remember_token
        cookies.signed[:remember_token] || [nil, nil]
    end
end
