require 'open-uri'
require 'digest/md5'

class PostsController < ApplicationController
  
  def new

  end
  
  def index
    @student =  Student.new
  end
  
  def create
    
    @student = Student.create(params[:post].permit(:name, :nickname, :email, :imageurl, :password, :password_confirmation)  )
        
     
    if @student.imageurl.empty?
      email_address = @student.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
      File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", open( "http://www.gravatar.com/avatar/#{hash}"
                                                                                           ).read, {mode: 'wb'})
    else
      
      File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", open( @student.imageurl.to_s ).read, {mode: 'wb'})
    
    end
    @student.imageurl =Student.count.to_s
    
    if @student.save
      session[:user_id] = @student.id
      flash[:notice] = " the student was successfully created."
      redirect_to :root
    else 
      render 'index'
    end  
  end
  
  def edit
    @student=Student.find(session[:user_id])
  end
  
  def test
  end
  def update
    @student = Student.find(params[:id])
    @tempImagePath  = @student.imageurl
    @student.update(params[:student].permit(:name, :nickname, :email, :imageurl))
    
    if( @student.imageurl.eql? "Delete")
      
      @student.imageurl = "default"
      
    elsif( @student.imageurl.eql?  "Change")
      
          if params[:new_image_url].empty?
            email_address = @student.email.downcase
            hash = Digest::MD5.hexdigest(email_address)
            File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", 
                    open( "http://www.gravatar.com/avatar/#{hash}").read, {mode: 'wb'})
          else
            File.write("/home/action/Bueller/app/assets/images/"+Student.count.to_s+".jpg", 
                    open( params[:new_image_url] ).read, {mode: 'wb'})
   
          end
          @student.imageurl =Student.count.to_s  
    else
      @student.imageurl = @tempImagePath  
    end

    @student.save
    redirect_to :root, :notice => "You successfully updated your profile. !"
  end
  
  def show
  end
  
  private
  def post_params
    params.require(:post).permit(:name, :nickname, :email, :imageurl, :password, :password_confirmation)  
  end
  
end
