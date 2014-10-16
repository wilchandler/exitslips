class HomeController < ApplicationController
  def index
  	if current_user.class == Teacher
    	redirect_to teacher_path(current_user)
    else 
    	p current_user
    	p user_session
    	redirect_to quizzes_path
    end
  end
end