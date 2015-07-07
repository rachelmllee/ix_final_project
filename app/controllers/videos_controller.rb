class VideosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :authorize_admin!, only: [:destroy]
  before_action :authorize_tutor_or_admin!, only: [:new, :create, :edit, :update]

  def authorize_admin!
  	unless current_user.admin?
  		@course = Course.find(params[:course_id])
      redirect_to course_path(@course), alert: "You can't do that -- you're not an admin!"
  	end
  end

  def authorize_tutor_or_admin!
    unless current_user.tutor? || current_user.admin?
      @course = Course.find(params[:course_id])
      redirect_to course_path(@course), alert: "You can't do that -- you're not a tutor nor an admin!"
    end
  end

  def index
    @course = Course.find(params[:course_id])
    @videos = @course.videos
  end

  def show
    @course = Course.find(params[:course_id])
    @video = @course.find(params[:id])
  end 

  def new
    @course = Course.find(params[:course_id])
    @video = @course.videos.new
  end

  def edit
    @course = Course.find(params[:course_id])
    @video = @course.videos.find(params[:id])
  end

  def create
    @course = Course.find(params[:course_id])
    @video = @course.videos.build(video_params)

    if @video.save
      redirect_to course_path(@course), notice: "Video successfully created"
    else
      render 'videos/new'
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @video = @course.videos.find(params[:id])

    if @video.update(video_params)
      redirect_to course_path(@course), notice: "Video successfully updated"
    else
      render 'videos/edit'
    end

  end

  def destroy 
    @course = Course.find(params[:course_id])
    @video = @course.videos.find(params[:id])
    @video.destroy

    redirect_to course_path(@course), notice: "Video successfully deleted"
  end

  private
    def video_params
      params.require(:video).permit(:title, :description, :length, :course_id, :url)
    end

  end