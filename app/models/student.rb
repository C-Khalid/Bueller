class Student < ActiveRecord::Base

  has_secure_password
  validates_presence_of :password, :on => :create
def current_user=(user)
    @current_user = user
  end
  def new_image_url=(new_url)
  end

end
