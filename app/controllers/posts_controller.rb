class PostsController < ApplicationController

  
  def new
  end
  
  def index
  end
  
  def create
   
    @student = Student.new(params[:post].permit(:name, :nickname, :email, :imageurl))
    File.write('whatever_file1.jpg', open( @student.imageurl ).read, {mode: 'wb'})
 
    if @student.save
      redirect_to :root
    else
      render 'new'
    end  
  end
  
  private
  def post_params
    params.require(:post).permit(:name, :nickname, :email, :imageurl)
  end
end
