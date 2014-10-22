class EnrollmentsController < ApplicationController

	# def new
	# 	@enrollment = Enrollment.new

	# end

	# def create
	# 	@section = Section.find_by(passcode: params[:passcode])
	# 	 if @section
	# 		Enrollment.create(student_id: current_user.id,section_id: @section.id)
	# 	 end
	# 	 redirect_to quizzes_path

	# end

	def create
		message = nil
		section = Section.find_by(passcode: params[:passcode].strip.downcase) unless params[:passcode].nil?
		if section
			student = Student.includes(:sections).find_by(id: current_user_id)
			if student.sections.include? section
				message = "You already joined this section"
			else
				student.sections << section
			end
		else
			message = "Section not found" unless @section
		end


		respond_to do |format|
			format.html {
				redirect_to section_path(section)
			}
			format.json {
				if message
					render json: {error: message}
				else
					render json: {
						success: section_path(section)
						# name: section.name,
						# teacher: section.teacher.name,
						# id: section.id
					}
				end
			}
		end
	end

		private

	def enrollment_params
		params.require(:enrollment).permit(:passcode)
	end


end
