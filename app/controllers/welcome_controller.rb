class WelcomeController < ApplicationController
  def index
    @students = Student.all
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end
  
end
