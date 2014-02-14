class Student < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  has_many :attendances
  has_secure_password
  validates_presence_of :password, :on => :create
  
  def Student.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Student.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.in_seat(seat, now)
       
	return Student.where ( Attendance.where(:seat => seat, :attended_on => now) )
  end

  def self.absent(now)
	return Student.where (  Attendance.where(:attendance => false, :attended_on => now) )
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
