class Sitting < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
  has_many :answers

  def self.average_sittings(sittings = [])
    return nil if sittings.empty?

    percentages = sittings.map { |sitting| sitting.calculate_percentage }
    (percentages.inject(:+).to_f / percentages.length.to_f).round
  end

  def calculate_percentage
    (self.correct.to_f / self.possible.to_f * 100).round
  end

  def self.grade_response(args = {})
    new_sitting = Sitting.create(
      student_id: args[:student_id],
      quiz_id: args[:quiz_id],
      correct: 0,
      possible: 0,
      graded: true
    )

    args[:responses].each do |question_id, option|
      question = Question.find_by(id: question_id)
      mark = question.check(option)
      Answer.create(
        student_id: args[:student_id],
        question_id: question_id,
        sitting_id: new_sitting.id,
        content: option,
        correct: mark
      )
      new_sitting.update_count( mark )
    end

    new_sitting.save
  end

  def update_count(mark)
    if mark == true
      self.correct += 1
      self.possible += 1
    elsif mark == false
      self.possible += 1
    elsif mark == :pending
      self.update_attribute(:graded, false)
    end
  end

end


