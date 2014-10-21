class AnswersController < ApplicationController

	def update
		answer = Answer.find_by(id: params[:id])
		answer.update(correct: params[:correct])
		if answer.save
			respond_to do |format|
			format.json {
					puts "JSON"
					render text: "Success!"
				}
				format.html {
					puts "HTML"
					@answers = answer.quiz.answers
				}
			end
		end
	end


end