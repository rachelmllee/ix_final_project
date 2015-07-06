class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :authorize_admin!, only: [:new, :create, :destroy]
  before_action :authorize_tutor_or_admin!, only: [:edit, :update]

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

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end 

  def new
    @course = current_user.courses.new
  end

  def edit
    @course = current_user.courses.find(params[:id])
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
    @course = current_user.courses.find(params[:id])

    if @course.update(course_params)
      redirect_to @course, notice: "Course successfully updated"
    else
      render 'edit'
    end

  end

  def destroy 
    @course = current_user.courses.find(params[:id])
    @course.destroy

    redirect_to courses_path, notice: "Course successfully deleted"
  end

  private
    def course_params
      params.require(:course).permit(:name, :description, :category, :grade)
    end

  end