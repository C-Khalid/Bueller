class WelcomeController < ApplicationController
  
  skip_before_filter :require_login
  
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
