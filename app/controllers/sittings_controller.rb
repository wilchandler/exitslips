class SittingsController < ApplicationController
  def create
    raise params.inspect
    raise params.values.inspect
    @responses = params.values
    Sitting.process_response({user: @id, responses: @responses})
    @quiz = Quiz.find_by(id: params[:quiz_id])
    @sitting = @quiz.sittings.new(params)
    if @sitting.save!
      redirect_to '/'
    end
    # update answers table after creating sitting
  end
end
