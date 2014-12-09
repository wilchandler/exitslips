class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :first_name, :last_name, :email, :password, :password_confirmation, :user_type) }
	end

  def current_teacher
    Teacher.find_by(id: current_user_id)
  end

  def current_student
    Student.find_by(id: current_user_id)
  end

  def current_user_id
    session["warden.user.user.key"][0][0]
  end

  def log_in_demo
    casey = User.find_by(email: ENV["DEMO_EMAIL"])
    if casey
      sign_in casey
    else
      return nil
    end
  end

end
