class Option < ActiveRecord::Base
  belongs_to :question

  def self.process_quiz_form(question_id, option_info)
    option = Option.find_by(id: option_info[:id]) || Option.new
    if option_info[:_destroy] == "1" || option_info[:content].strip.empty?
      option.destroy
    else
      option.update_attributes(
        question_id: question_id,
        correct?: option_info[:correct?],
        content: option_info[:content].strip
      )
    end
  end
end
