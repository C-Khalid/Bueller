class WelcomeController < ApplicationController
  def index
    @students = Student.all
    
    date = params[:date]   
    if date.nil?
      @date = Date.today
    else
      @date = Date.strptime( date.gsub("/","-") , '%m-%d-%Y')
    end
  end
  
end
