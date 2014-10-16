class HomeController < ApplicationController
  def index
  	# redirect_to teacher_path(current_user) if user_signed_in?

    if user_signed_in? && current_user.class == Teacher
    	redirect_to teacher_path(current_user)
    elsif user_signed_in? && current_user.class == Student
    	redirect_to quizzes_path
    end
  end
end
