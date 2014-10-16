class SectionsController < ApplicationController

	def index
		@sections = Section.all
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new
		render :layout =>false
	end

	def create
		
		@section = Section.new(section_params)
		if @section.save! 
			redirect_to sections_path

		end

	end

	def edit
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
    	params.require(:section).permit(:name, :text)
  end
	
end
