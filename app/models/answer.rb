class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :student
  belongs_to :sitting

  def self.average_answers(answers = [])
  	return nil if answers.empty?

  	percentages = answers.map { |answer| answer.calculate_percentage }
  	(percentages.inject(:+).to_f / percentages.length.to_f).round
  end

  def calculate_percentage
    (self.correct.to_f / self.possible.to_f * 100).round
  end

end
