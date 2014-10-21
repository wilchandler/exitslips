class MakeQuestionMultipleChoiceByDefault < ActiveRecord::Migration
  def change
    change_column :questions, :question_type, :string, :default => 'multiple_choice'
  end
end
