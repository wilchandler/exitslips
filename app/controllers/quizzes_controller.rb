class QuizzesController < ApplicationController

	def index

	end

	def show
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def delete
	end

	def sort_results
		@session = Section.find_by_id(params[:section_id])
		@quiz = Quiz.find_by_id(params[:id])
	end
end
