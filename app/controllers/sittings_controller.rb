class SittingsController < ApplicationController
  def create
    raise params.inspect
    sitting = Sitting.new(quiz_sitting_params)
    if sitting.save!
      redirect_to '/'
    end
    # update answers table after creating sitting
  end
end
