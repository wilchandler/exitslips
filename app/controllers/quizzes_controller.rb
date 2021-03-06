class QuizzesController < ApplicationController


	def index
		@sections = current_user.sections
		@quizzes = current_user.quizzes
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
		failures = []
		params[:sections].keys.each do |section_id|
			section = Section.find_by(id: section_id)
			requirement = Requirement.find_by(section_id: section_id.to_i, standard_id: params[:standard])
			if section && section.teacher_id == current_teacher.id
				if requirement
					quiz = Quiz.new(section: section, requirement: requirement)
					quiz.process_quiz_form(params[:quiz])
				else
					failures << section.name
				end
			else
				flash[:error] = "Unable to save quiz."
			end

		end

		check_for_requirement_errors(failures)
		redirect_to sections_path
	end

	def edit
		@quiz = Quiz.find_by(id: params[:id])
		@questions = @quiz.questions
		@section = @quiz.section
		@standard_current = @quiz.requirement.standard_id
		@standard_options = @section.standards.map{ |s| [s.code, s.id] }
	end

	def update
		quiz = Quiz.find_by(id: params[:id])
		requirement = Requirement.find_by(section_id: quiz.section_id, standard_id: params[:standard])
		quiz.update_attribute(:requirement, requirement)
		quiz.process_quiz_form(params[:quiz])
		redirect_to quiz_path(quiz)
	end

	def delete
	end

	def results
		@section = Section.find_by(id: params[:section_id])
		@quiz = Quiz.find_by(id: params[:id])

		respond_to do |format|
			format.html {
		    @students = @section.students
		    @questions = @quiz.questions
		    @sittings = @quiz.sittings
		  }
		  format.json { render json:  { scores: @quiz.calculate_scores_by_question } }
		end
	end

	def groups
		group_size = params[:group_size].to_i
		sort_type = params[:sort_type].to_sym
		quiz = Quiz.find_by(id: params[:id])

		respond_to do |format|
			format.json { render :json => {
				groups: quiz.group_by_quiz_scores(group_size, sort_type)
			}}
		end
	end

	def grade
		@quiz = Quiz.find_by(id: params[:id])
		@ungraded_answers = @quiz.get_ungraded_answers
	end

		private

	def quiz_params
		params.require(:quiz).permit(:name, :instructions, :section_id)
	end

	def check_for_requirement_errors(failures = [])
		return if failures.empty?
		flash[:alert] = "The selected standard does not apply to the following sections: #{failures.join(", ")}"
	end
end
