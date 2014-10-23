class SittingsController < ApplicationController

  def new
    @quiz = Quiz.find_by(id: params[:quiz_id])
    @questions = @quiz.questions
  end

  def create
    responses = params[:response]

    quiz = Quiz.includes(:section).find_by(id: params[:quiz_id])
    student = Student.find_by(id: current_user_id)
    sittings_beginning_count = student.sittings.count

    Sitting.grade_response({
      responses: responses,
      quiz_id: params[:quiz_id],
      student_id: current_user_id
    })

    sittings_new_count = student.sittings.count
    if sittings_new_count > sittings_beginning_count
      flash[:notice] = "Quiz successfully submitted!"
    else
      flash[:error] = "Something went wrong..."
    end
    redirect_to section_path(quiz.section)
  end

end
