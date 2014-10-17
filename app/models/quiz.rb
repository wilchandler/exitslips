class Quiz < ActiveRecord::Base
	belongs_to :section
	has_many :questions
	belongs_to :student, class_name: "User"

  accepts_nested_attributes_for :questions, allow_destroy: true

  def process_quiz_form(args = {})
    self.update_attributes(
      name: args[:name],
      instructions: args[:instructions]
    )
    questions = args[:questions_attributes].values
    questions.each do |question_data|
      Question.process_quiz_form(self.id, question_data)
    end
  end

end
