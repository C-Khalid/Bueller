class AttendancesController < ApplicationController

  def index
  end
 
  def create
  
    attendance = Attendance.new
    attendance.attendance = true
    attendance.attended_on = Date.today
    attendance.seat = params[:attendance][:seat]
    attendance.now = DateTime.now
    attendance.student_id = current_user.id
    attendance.save
    render 'show'
  end
  
  private
  def attendance _params
    params.require(:attendance).permit!
  end
  
end
