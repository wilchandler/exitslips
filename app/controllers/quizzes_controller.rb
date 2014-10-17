class QuizzesController < ApplicationController


	def index
	end

	def teacher_index
	end

	def show
		@quiz = Quiz.find_by(id: params[:id])
	end

	def take

	end

	def new
		@section = Section.find_by(id: params[:section_id])
		@quiz = Quiz.new
		@questions = @quiz.questions
	end

	def create
		# @quiz = Quiz.new(quiz_params)
		# @quiz.section_id = params[:section_id]
		# @quiz.save
		# redirect_to section_quiz_path(params[:section_id], @quiz)
		quiz = Quiz.new(section_id: params[:section_id])
		quiz.process_quiz_form(params[:quiz])
		redirect_to section_quiz_path(params[:section_id], quiz)
	end

	def edit
		@quiz = Quiz.find_by(id: params[:id])
		@section = Section.find_by(id: params[:section_id])
	end

	def update
		# raise params[:quiz][:questions_attributes].values.inspect
		quiz = Quiz.find_by(id: params[:id])
		quiz.process_quiz_form(params[:quiz])
		redirect_to section_quiz_path(params[:section_id], quiz)
	end

	def delete
	end


		private

	def quiz_params
		params.require(:quiz).permit(:name, :instructions, :section_id)
	end
end
