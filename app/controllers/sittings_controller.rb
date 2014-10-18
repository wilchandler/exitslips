class SittingsController < ApplicationController


  def new
    @quiz = Quiz.find_by(id: params[:quiz_id])
  end

  def create
    @responses = params[:response].values
    num_correct = @responses.count("true")
    @quiz = Quiz.find_by(id: params[:quiz_id])
    @sitting = Sitting.new(student_id: current_user_id[0], quiz_id: @quiz.id, possible: @quiz.questions.count, correct: num_correct)
    if @sitting.save!
      redirect_to quizzes_finish_path(@quiz)
    else
      redirect_to quiz_path(@quiz)
    end
    # update answers table after creating sitting
  end


end


# quiz 1
# question 1 = 4
# question 2 = 2
