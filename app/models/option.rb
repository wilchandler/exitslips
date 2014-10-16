class Option < ActiveRecord::Base
	belongs_to :question

  def self.process_options(args = {})
    quiz = Quiz.find_by(id: args[:quiz_id])
    questions = args[:questions]
    questions.each_value do |q|
      new_question = Question.create(
        query: q["query"],
        quiz_id: quiz.id
        # standard_id
        # type
      )
      raise q.inspect
    end
  end
end
