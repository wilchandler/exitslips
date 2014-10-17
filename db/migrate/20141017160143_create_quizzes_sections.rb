class CreateQuizzesSections < ActiveRecord::Migration
  def change
    create_table :quizzes_sections do |t|
      t.integer :quiz_id
      t.integer :section_id
    end
  end
end
