class CreateSectionTeachers < ActiveRecord::Migration
  def change
    create_table :section_teachers do |t|
      t.integer :section_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
