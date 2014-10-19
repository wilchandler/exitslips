class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.string :content
      t.boolean :correct
      t.integer :student_id
      t.integer :sitting_id
    end
  end
end
