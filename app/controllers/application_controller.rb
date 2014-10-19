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
    Teacher.find_by(id: session["warden.user.user.key"][0])
  end

  def current_user_id
    session["warden.user.user.key"][0]
  end

end
