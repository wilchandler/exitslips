class HomeController < ApplicationController
  def index
  	# redirect_to teacher_path(current_user) if user_signed_in?
    if user_signed_in? && current_user.class == Teacher
    	debugger
    	redirect_to sections_path
    elsif user_signed_in? && current_user.class == Student
    	debugger
    	redirect_to quizzes_path
    end
    debugger
  end
end
