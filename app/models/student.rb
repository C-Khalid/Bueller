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

  def self.in_seat(seat, date)
    Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
  end

  def self.absent(date)
    Student.joins(:attendances).where.not(attendances: {attended_on: date})
  end

  private

    def create_remember_token
      self.remember_token = Student.encrypt(Student.new_remember_token)
    end
end
