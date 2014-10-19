class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers
  has_many :options

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
      )
      options = question_info[:options_attributes].values
      options.each do |option_data|
        Option.process_quiz_form(question.id, option_data)
      end
    end
  end

  def check(option)
    if self.question_type == "multiple_choice"
      return check_multiple_choice(option)
    else
      # open response...
    end
    debugger
  end

  def check_multiple_choice(user_option_id)
    options = Option.where(question_id: self.id)
    options.each do |option|
      if option.id.to_s == user_option_id
        return option.correct?
      end
    end
    return false
  end

end
