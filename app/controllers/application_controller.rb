class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
   	courses_path
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

      protected

          def configure_permitted_parameters
              devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :role) }
              devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :date_of_birth, :phone_no, :role) }
          end
      
end
