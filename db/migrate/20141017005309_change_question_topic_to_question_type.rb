class ChangeQuestionTopicToQuestionType < ActiveRecord::Migration
  def change
    rename_column :questions, :topic, :question_type
  end
end
