class QuizzesController < ApplicationController


	def index
	end

	def teacher_index
	end

	def show
		@quiz = Quiz.find_by(id: params[:id])
	end

	def new
		@sections = Section.where(teacher_id: current_user.id)
		@quiz = Quiz.new
		@questions = []

		@standards = Teacher.find( current_user.id ).standards #UGH
	end

	def create
		# NEED TO VALIDATE IF NO SECTIONS ARE SELECTED OR NO Q/A

		params[:sections].keys.each do |section_id|
			section = Section.find_by(id: section_id)
			if section && section.teacher_id == current_teacher.id
				quiz = Quiz.new(section_id: section, standard_id: params[:quiz][:standard])
			end
			quiz.process_quiz_form(params[:quiz])
		end
		redirect_to sections_path
	end

	def edit
		@quiz = Quiz.find_by(id: params[:id])
		@standard = @quiz.standard
	end

	def update
		quiz = Quiz.find_by(id: params[:id])
		quiz.process_quiz_form(params[:quiz])
		redirect_to quiz_path(quiz)
	end

	def delete
	end

	def finish

	end


		private

	def quiz_params
		params.require(:quiz).permit(:name, :instructions, :section_id)
	end
end
