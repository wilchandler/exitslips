class SectionsController < ApplicationController
	include SectionsHelper

	before_action :authenticate_user!

	def index
		# student_leave
	  #--------Mastery---------------
	  respond_to do |format|
	  	format.json {
			  render json: current_teacher.mastery_by_section
	  	}
	  	format.html{
	  		@teacher = current_teacher
			  @sections = @teacher.sections
			  @mastery = @teacher.mastery_for_all_sections
	  	}
	  end
	end

	def info

		respond_to do |format|
			
			
 			section_id = params["section"]
 			standard_id = params["standard"]
			student_id = params["student"]
			stu_number = student_id.to_i
			stan_number = standard_id.to_i
			sec_number = section_id.to_i
			requirement = Requirement.where(standard_id:stan_number,section_id:sec_number)
			new_requirement = requirement.first
			quiz = new_requirement.quizzes
			new_quiz = quiz.first
			sitting = Sitting.where(student_id:stu_number,quiz_id:new_quiz.id)
		    new_sitting = sitting.first
			
			percentage = new_sitting.calculate_percentage

			answers =[]
			all_answers = new_sitting.answers
			puts 100000
			puts all_answers.pluck(:id)
			all_answers.each do |answer|
				if answer.correct == false
					answers << answer.question.query
				end
			end
			
			format.json{
				render :json => {grade: percentage,wrong_answers: answers}
			}
		end
	end
			
			
			
			
			
			
			

	def show_bargraph
		respond_to do |format|
			format.json {
				render plain: "hello world"
			}
		end
	end

	def show
		# student_leave
		@section = Section.find(params[:id])
		@quizzes = @section.quizzes

		respond_to do |format|
      format.html {
        @students = @section.students
        @standards = @section.standards
        @quizzes = @section.quizzes
      }
      format.json {
        render json: @section.calculate_scores_by_standard
      }
      format.csv {
        send_data @section.to_csv
      }
		end
	end

  def confirm
  	@section = Section.find(params[:section_id])
  end

  def confirmed
  	@section = Section.find(params[:section_id])
  	if params[:passcode] = @section.passcode ||
  		Enrollment.create(section_id:@section.id,student_id:current_user.id)
  		redirect_to section_path(@section)
  	else
  		redirect_to sections_path
		end
  end

  def new
	 	# student_leave
	 	@section = Section.new
		@teacher = current_user
	  @sections = current_user.sections
	  @quizzes = current_user.quizzes

	end

	def create
		@section = Section.new(section_params)
		@section.teacher_id = current_user.id
		if @section.save!
			redirect_to '/'
		end
	end


	def edit
	  student_leave
	  @section = Section.find(params[:id])
	end

	def update
		@section = Section.find(params[:id])
		@section.update(section_params)
		if @section.save
			redirect_to sections_path
    else
    	render 'edit'
    end
	end

	def destroy
		@section = Section.find(params[:id])
		 if @section.destroy
		 	redirect_to sections_path
		 else
		 	redirect_to sections_path
		 end
	end

	def add_section
		passcode = params[:add_section].values[0]
		section = Section.find_by(passcode: passcode)
		if section == nil
			# add error message
			redirect_to quizzes_path
		else
			Enrollment.create(section_id: section.id, student_id: current_user_id)
			redirect_to quizzes_path
		end
	end

	private
    def section_params
    	params.require(:section).permit(:name,:subject,:grade)
    end
end





