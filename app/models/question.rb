class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers
  has_many :options

  accepts_nested_attributes_for :options, allow_destroy: true

  def self.process_quiz_form(quiz_id, question_info)
    question = Question.find_by(id: question_info[:id]) || Question.new

    if question_info[:_destroy] == "1" || question_info[:query].strip.empty?
      question.destroy_options
      question.destroy
    else
      question.update_attributes(
        quiz_id: quiz_id,
        query: question_info[:query].strip,
      )

      if question_info[:question_type] == "0" # multiple choice
        question.process_options_from_form(question_info[:options_attributes].values)
      elsif question_info[:question_type] == "1" # open response
        question.make_open_response
      end

    end
    question
  end

  def process_options_from_form(options)
    self.update_attribute(:question_type, "multiple_choice")
    options.each do |option_data|
      Option.process_quiz_form(self.id, option_data)
    end
  end

  def make_open_response
    destroy_options if self.question_type == "multiple_choice"
    self.update_attribute(:question_type, "open_response")
  end

  def check(option)
    if self.question_type == "multiple_choice"
      return check_multiple_choice(option)
    else
      return :pending
    end
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

  def destroy_options
    self.options { |option| option.destroy } if self.id
  end
end
