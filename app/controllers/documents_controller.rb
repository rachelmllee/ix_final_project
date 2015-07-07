class DocumentsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]

  before_action :authorize_admin!, only: [:destroy]
  before_action :authorize_tutor_or_admin!, only: [:edit, :update :new, :create]

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

  def create
  		@course = Course.find params[:course_id]
		@document = @course.documents.build(document_params)
		@document.user_id = document_user.id
		@document.save
		redirect_to course_path(@course)
	
  end

  def edit
  		@course = Course.find(params[:course_id])
  		@document = Document.find(params[:id])
  end

  def update
  		@course =Course.find(params[:course_id])
  		@document = @course.documents.find(params[:id])
 		
 		if @documet.update(document_params)
 			redirect_to document_path(@document)
 		else
 			render 'edit'
 		end
  end

  def destroy
  		@course =Course.find(params[:course_id])
  		@document= @course.documents.find(params[:id])
  		@document.destroy
  		redirect_to course_path(@course)
  end

  private
  def document_params
  		params.require(:document).permit(:title, :description, :file)
  end
end