class AttendancesController < ApplicationController

  def index
  end
  
  def create
  
    attendance = Attendance.new
    attendance.attendance = true
    attendance.attended_on = Date.today
    attendance.seat = params[:commit].to_i
    attendance.now = DateTime.now
    attendance.student_id = current_user.id
    attendance.save
    
	  flash[:notice] = "You were in seat "+ params[:commit]
	  redirect_to :root
  end
  
  private
  def attendance _params
    params.require(:attendance).permit!
  end
  
end