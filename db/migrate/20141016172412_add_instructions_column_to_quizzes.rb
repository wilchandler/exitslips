class AddInstructionsColumnToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :instructions, :text
  end
end
