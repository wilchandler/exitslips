class QuizzesController < ApplicationController


	def index
		@sections = current_user.sections
		@quizzes = current_user.quizzes
	end

	def teacher_index
	end

	def show
		@quiz = Quiz.find_by(id: params[:id])
	end

	def new
		@quiz = Quiz.new
		@questions = []
		availabilities = Teacher.get_available_sections_and_standards( current_user.id)
		@sections = availabilities[:sections]
		@standard_options = availabilities[:standards]
	end

	def create
		# NEED TO VALIDATE IF NO SECTIONS ARE SELECTED OR NO Q/A

		params[:sections].keys.each do |section_id|
			section = Section.find_by(id: section_id)
			requirement = Requirement.find_by(section_id: section_id, standard_id: params[:standard])
			if section && section.teacher_id == current_teacher.id && requirement
				quiz = Quiz.new(section: section, requirement: requirement)
			end
			quiz.process_quiz_form(params[:quiz])
			raise quiz.inspect
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
