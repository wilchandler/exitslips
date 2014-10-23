class SittingsController < ApplicationController

  def new
    @quiz = Quiz.find_by(id: params[:quiz_id])
    @questions = @quiz.questions
  end

  def create
    responses = params[:response]

    quiz = Quiz.includes(:section).find_by(id: params[:quiz_id])

    Sitting.grade_response({
      responses: responses,
      quiz_id: params[:quiz_id],
      student_id: current_user_id
    })

    flash[:notice] = "Quiz successfully submitted!"
    redirect_to section_path(quiz.section)
  end
end
