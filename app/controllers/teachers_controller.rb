class TeachersController < ApplicationController
  
  def index
    
  end

  def show
    @teacher = current_user
    @sections = current_user.sections
    @quizzes = current_user.quizzes
  end 

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end