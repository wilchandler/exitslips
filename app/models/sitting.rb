class Sitting < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
  has_many :answers

  def self.average_sittings(sittings = [])
    return nil if sittings.empty?

    percentages = sittings.map { |sitting| sitting.calculate_percentage }
      return nil if percentages.all? &:nil?
      (percentages.inject(:+).to_f / percentages.length.to_f).round
  end

  def calculate_percentage
    return nil if self.possible == 0
    (self.correct.to_f / self.possible.to_f * 100).round
  end

  def self.grade_response(args = {})
    new_sitting = Sitting.create(
      student_id: args[:student_id],
      quiz_id: args[:quiz_id],
      correct: 0,
      possible: 0
    )

    args[:responses].each do |question_id, option|
      question = Question.find_by(id: question_id)
      mark = question.check(option)
      Answer.create(
        question: question,
        student_id: args[:student_id],
        sitting: new_sitting,
        content: option
      )
      new_sitting.update_count( question.check(option) )
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
      # handle open ended response
    end
  end

end


