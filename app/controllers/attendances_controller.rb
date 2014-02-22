class AttendancesController < ApplicationController

  def index
  end
 
  def create
  
    if Attendance.where(:student_id => current_user.id , :attended_on => Date.today).empty?
      attendance = Attendance.new
      attendance.attendance = true
      date = params[:attendance]
      attendance.attended_on = Date.new date["attended_on(1i)"].to_i, date["attended_on(2i)"].to_i, date["attended_on(3i)"].to_i
      attendance.seat = params[:attendance][:seat]
      attendance.now = DateTime.now
      attendance.student_id = current_user.id
      attendance.save
    else
      flash[:notice] = "You have already created an attendance for today!"
    end
    
    redirect_to :root
    
  end
  
  private
  def attendance _params
    params.require(:attendance).permit!
  end
  
end
