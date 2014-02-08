class SessionsController < ApplicationController
  def new
  end

  def create
    user = Student.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!" + user.name
      remember_token = Student.new_remember_token
      cookies.permanent[:remember_token] = remember_token
      user.update_attribute(:remember_token, Student.encrypt(remember_token))
      self.current_user = user
    else
      flash.now.alert = "Invalid email or password"
      render "index"
    end
  end

  def destroy
    sign_out
    reset_session
    redirect_to root_url
  end
  
end
