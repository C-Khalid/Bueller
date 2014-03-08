class WelcomeController < ApplicationController
  
  skip_before_filter :require_login
  
  def home
    
    if !current_user.nil?
      render "index"
    end
  end
  
  def index
    
    if current_user.nil?
      render "home"
    else
      
      @students = Student.all
      date = params[:date]   
      if date.nil?
        @date = Date.today
      else
        @date = Date.strptime( date.gsub("/","-") , '%m-%d-%Y')
      end  
      
    end
    
  end
  
end
