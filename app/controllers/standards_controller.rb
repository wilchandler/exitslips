class StandardsController < ApplicationController

  def index
    teacher = Teacher.find_by(id: current_user.id) # this isn't very efficient.. how to current id?
    render json: teacher.standards if teacher# some unnecessary fields being passed back
  end

end
