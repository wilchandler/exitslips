class Question < ActiveRecord::Base
	belongs_to :quiz
	belongs_to :standard
	has_many :options
	has_many :answers

  accepts_nested_attributes_for :options, allow_destroy: true

  def self.process_quiz_form(args = {})
    quiz = Quiz.find_by(id: args[:quiz_id])
    questions = args[:questions]
    questions.each_value do |q|
      new_question = Question.create(
        query: q["query"],
        quiz_id: quiz.id
        # standard_id
        # type
      )
      options = Option.process_quiz_form
      raise options.inspect
    end
  end

end
