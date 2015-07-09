class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :authorize_admin!, only: [:new, :create, :destroy]
  before_action :authorize_tutor_or_admin!, only: [:edit, :update]

  # before_action :get_mailbox
  # before_action :get_conversation, except: [:index, :empty_trash]

  def authorize_admin!
  	unless current_user.admin?
  		redirect_to :courses, alert: "You can't do that -- you're not an admin!"
  	end
  end

  def authorize_tutor_or_admin!
    unless current_user.tutor? || current_user.admin?
      redirect_to :courses, alert: "You can't do that -- you're not a tutor nor an admin!"
    end
  end


  def admin
    @courses = Course.all
    @users =User.all
    @tutors = User.where(role: 'tutor')
    @students = User.where(role: 'student')

  end
  
  # def get_mailbox
  #   @mailbox ||= current_user.mailbox
  # end

  # def get_conversation
  #   @conversation ||= @mailbox.conversations.find(params[:id])
  # end

  # def requests
  #   @conversations = @mailbox
  #   #@participants =@conversations.participants

  # end

  def search
    @courses = Course.search(params[:q])
    render :index
  end

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @document= Document.new
    @video = Video.new
  end 

  def new
    @course = current_user.courses.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to @course, notice: "Course successfully created"
    else
      render 'new'
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to @course, notice: "Course successfully updated"
    else
      render 'edit'
    end

  end

  def destroy 
    @course = Course.find(params[:id])
    @course.destroy

    redirect_to courses_path, notice: "Course successfully deleted"
  end

  private
    def course_params
      params.require(:course).permit(:name, :description, :category, :grade)
    end

end