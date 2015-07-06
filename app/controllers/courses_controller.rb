class CoursesController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_admin!, except: [:index, :show]

  def authorize_admin!
  	binding.pry
  	unless current_user.admin?
  		redirect_to :root, alert: "You can't do that!"
  	end
  end

  def index
  end

  def new
  end
end