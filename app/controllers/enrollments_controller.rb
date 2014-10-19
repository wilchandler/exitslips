class EnrollmentsController < ApplicationController

	def new 
		@enrollment = Enrollment.new

	end

	def create
		@section = Section.find_by(passcode: params[:passcode])
		 if @section
			Enrollment.create(student_id: current_user.id,section_id: @section.id)
		 end
		 redirect_to quizzes_path

	end

	private
		def enrollment_params
			params.require(:enrollment).permit(:passcode)
		end
	

end