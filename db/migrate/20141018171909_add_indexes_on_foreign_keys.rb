class AddIndexesOnForeignKeys < ActiveRecord::Migration
  def change
    add_index :answers, :question_id
    add_index :answers, :student_id
    add_index :answers, :sitting_id

    add_index :enrollments, :section_id
    add_index :enrollments, :student_id

    add_index :options, :question_id

    add_index :questions, :quiz_id

    add_index :quizzes, :standard_id
    add_index :quizzes, :section_id

    add_index :sections, :teacher_id

    add_index :sittings, [:quiz_id, :student_id]
    add_index :sittings, :student_id
  end
end
