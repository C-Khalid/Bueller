module SessionsHelper
  def sign_in(student)
    remember_token = Student.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    student.update_attribute(:remember_token, Student.encrypt(remember_token))
    self.current_user = student
  end
  
  def sign_out
    
    current_user.update_attribute(:remember_token,
    Student.encrypt(Student.new_remember_token))
    cookies.delete(:remember_token)
    current_user = nil
    
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(student)
    @current_user = student
  end
   def current_user
    remember_token = Student.encrypt(cookies[:remember_token])
    @current_user ||= Student.find_by(remember_token: remember_token)
  end
end
