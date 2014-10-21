class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :student
  belongs_to :sitting

  def self.average_answers(answers = [])
  	return nil if answers.empty?

    correct = 0
    answers.each { |a| correct += 1 if a.correct }

    (correct.to_f / answers.length * 100).round
  end

  def calculate_percentage
    (self.correct.to_f / self.possible.to_f * 100).round
  end

end
