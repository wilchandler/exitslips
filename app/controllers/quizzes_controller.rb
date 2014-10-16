class QuizzesController < ApplicationController


	def index
	end

	def show
		@quiz = Quiz.find_by(id: params[:id])
	end

	def new
		@section = Section.find_by(id: params[:section_id])
		# @section_id = 1 #FIX ME
		@quiz = Quiz.new
		@questions = @quiz.questions
	end

	def create
		@quiz = Quiz.new(quiz_params)
		@quiz.section_id = params[:section_id]
		@quiz.save
		#pass off options
		# Question.process_quiz_form({ quiz_id: @quiz.id, questions: params[:quiz][:questions_attributes] })
		redirect_to section_quiz_path(params[:section_id], @quiz)
	end

	def edit
		@quiz = Quiz.find_by(id: params[:id])
		@section = Section.find_by(id: params[:section_id])
	end

	def update
		raise params.inspect
	end

	def delete
	end

		private

	def quiz_params
		params.require(:quiz).permit(:name, :instructions, :section_id)
	end
end
