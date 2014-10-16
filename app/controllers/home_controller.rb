class HomeController < ApplicationController
  def index
    redirect_to teacher_path(current_user) if user_signed_in?
  end
end