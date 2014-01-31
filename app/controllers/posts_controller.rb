require 'open-uri'
require 'digest/md5'

class PostsController < ApplicationController

  
  def new
  end
  
  def index
  end
  
  def create
    
    @student = Student.new(params[:post].permit(:name, :nickname, :email, :imageurl))
    getPic(@student)
    
    if @student.save
      redirect_to :root
    else
      render 'new'
    end  
  end
  
  def edit
    @student=Student.find(params[:id])
  end
  
  def update
    @student = Student.find(params[:id])
    @student.update(params[:student].permit(:name, :nickname, :email, :imageurl))
    getPic(@student)
    @student.save
    redirect_to :root
  end
  
  def show
  end
  
  private
  def post_params
    params.require(:post).permit(:name, :nickname, :email, :imageurl)
  end
  
  def getPic(student)
    
    if :imageurl.nil?
      File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", open( @student.imageurl ).read, {mode: 'wb'})
    else
      email_address = @student.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
      File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", open( "http://www.gravatar.com/avatar/#{hash}"
                                                                                           ).read, {mode: 'wb'})
    end
    @student.imageurl =Student.count.to_s
  end
  
end
