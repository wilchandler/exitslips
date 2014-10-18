class SectionsController < ApplicationController
	include SectionsHelper

	before_action :authenticate_user!

	def index
		# student_leave
		@sections = Section.all
		@teacher = current_user
	  @sections = @teacher.sections
	  @quizzes = @teacher.quizzes
	end

	def show
		# student_leave
		@section = Section.find(params[:id])
		@students = @section.students
    @standards = @section.standards



		respond_to do |format|
      format.json {
        render json: @section.calculate_scores_by_standard
      }
			format.html {
        @quizzes = @section.quizzes
      }
		end


    # FIND all students
    # FIND all standards
    # RENDER empty table

    # ON READY
      # GET data

    # ON select menu change
      # HIDE active table
      # make new GET request

    # STANDARDS TABLE
    #   class: table-active/table-inactive
    #   ID: table-all-standards

    # QUIZ TABLE
    #   class: table-active/table-inactive
    #   ID: table-quiz (or table-quiz-(:id) )

    # TABLE DATA
    #   red: class red
    #   yellow: class yellow
    #   green: class green

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

	private
    def section_params
    	params.require(:section).permit(:name,:subject,:grade)
    end
end





