class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.integer :section_id
      t.integer :student_id

      t.timestamps
    end
  end
end
