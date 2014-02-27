class WelcomeController < ApplicationController
  def index
    @students = Student.all  
    date = params[:root]
    
    if date.nil?
      @date = Date.today
    else
      @date = Date.new date["attended_on(1i)"].to_i, date["attended_on(2i)"].to_i, date["attended_on(3i)"].to_i    
    end
   
  end
  
end
