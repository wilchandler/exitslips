class QuizzesController < ApplicationController

	def index
	end

	def show
		@quiz = quiz.find_by(params[:id])
	end

	def new
		@section_id = 1 #FIX ME
		@quiz = Quiz.new
		@questions = @quiz.questions
	end

	def create
		@quiz = Quiz.new(quiz_params)
		@quiz.section_id = params[:section_id]
		@quiz.save
		#pass off options
		raise params.inspect
		Option.process_options({ quiz_id: @quiz.id, questions: params[:quiz][:questions_attributes] })
		redirect_to section_quiz_path(params[:section_id], @quiz)
	end

	def edit
	end

	def update
	end

	def delete
	end

		private

	def quiz_params
		params.require(:quiz).permit(:name, :instructions, :section_id)
	end
end
