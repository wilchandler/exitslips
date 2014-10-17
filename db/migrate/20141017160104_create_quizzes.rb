class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :standard_id
      t.string :name
      t.text :instructions
      t.integer :section_id
    end
  end
end
