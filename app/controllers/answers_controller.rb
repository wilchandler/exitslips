class AnswersController < ApplicationController

	def update
		answer = Answer.find_by(id: params[:id])
		success = answer.record_open_response_grade(params[:correct])

		if success
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
