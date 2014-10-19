class SittingsController < ApplicationController


  def new
    @quiz = Quiz.find_by(id: params[:quiz_id])
    @questions = @quiz.questions
  end

  def create
    responses = params[:response]

    Sitting.grade_response({
      responses: responses,
      quiz_id: params[:quiz_id],
      student_id: current_user_id
    })

    redirect_to quizzes_finish_path(params[:quiz_id])
  end

end
