class Question < ActiveRecord::Base
	belongs_to :quiz
	belongs_to :standard
	has_many :options
	has_many :answers

  accepts_nested_attributes_for :options, allow_destroy: true

  def self.process_quiz_form(quiz_id, question_info)
    question = Question.find_by(id: question_info[:id]) || Question.new
    if question_info[:_destroy] == "1" || question_info[:query].strip.empty?
      question.options { |option| option.destroy }
      question.destroy
    else
      question.update_attributes(
        quiz_id: quiz_id,
        query: question_info[:query].strip,
        # standard_id: question_info[:standard_id],
        # topic: question_info[:topic]
      )
      options = question_info[:options_attributes].values
      options.each do |option_data|
        Option.process_quiz_form(question.id, option_data)
      end
    end
  end
end



# Quiz controller
#   pass to...
# Quiz model
#   pass questions to...
# Question model
#   update question
#   pass options to...
# Option model
#   update options
