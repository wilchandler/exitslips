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

  def record_open_response_grade(mark)
    success = update_attribute(:correct, mark)
    sitting = self.sitting
    sitting.update_count(self.correct)
    sitting.mark_graded_if_all_graded
    success
  end

end
