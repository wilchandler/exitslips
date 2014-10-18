class TeachersController < ApplicationController

  def show
    teacher = Teacher.find_by(id: params[:id])
    render json: teacher.standards  # some unnecessary fields being passed back
  end

end
