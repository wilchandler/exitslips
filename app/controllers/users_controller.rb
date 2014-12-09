class UsersController < ApplicationController

  def demo
    if log_in_demo
      redirect_to sections_path
    else
      redirect_to root_path
    end
  end

end