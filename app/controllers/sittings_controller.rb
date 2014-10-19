class SittingsController < ApplicationController


  def new
    @quiz = Quiz.find_by(id: params[:quiz_id])
  end

  def create
    @qtion = params[:response]
    @responses = params[:response].values
    correctarray =[]
    @responses.each {|x| correctarray << (Option.find_by(id: x)).correct?}
    num_correct = correctarray.count(true)

    @quiz = Quiz.find_by(id: params[:quiz_id])
    @sitting = Sitting.new(student_id: current_user_id[0], quiz_id: @quiz.id, possible: @quiz.questions.count, correct?: num_correct)

    if @sitting.save
      @qtion.each do |key, value|
        option = Option.find_by(id: value)
        @answer = Answer.create(question_id: key, content: option.content, correct?: option.correct?, student_id: current_user_id[0], sitting_id: @sitting.id)
      end
      redirect_to quizzes_finish_path(@quiz)
    else
      redirect_to quiz_path(@quiz)
    end
  end
end
