class CoursesController < ApplicationController
    before_action :authenticate_user!

    before_action :authorize_admin!, only: [:destroy, :create, :new]
    before_action :authorize_tutor_or_admin!, only: [:edit, :update]

    def authorize_admin!
    	#binding.pry
    	unless current_user.admin?
    		redirect_to :root, alert: "You can't do that!"
    	end
    end


    def authorize_tutor_or_admin!
      unless current_user.tutor? || current_user.admin?
        redirect_to :root, alert: "You can't do that!"
      end
    end

    def index
      @courses =Course.all

     end

    def new
      @course =Course.new
    end

    def show
      @course = Course.find(params[:id])
    end 

    def edit
      @course =Course.find(params[:id])
    end

    def create

      @course =Course.new(course_params)

      if course.save
          redirect_to @course
      else
        render 'new'
      end
    end

  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to @course
    else
      render 'edit'
    end

  end

    def destroy 
      @course = Course.find(params[:id])
      @course.destroy

      redirect_to courses_path
    end

  private

  def course_params
    params.require(:course).permit(:name, :description, :category, :grade)
  end

end