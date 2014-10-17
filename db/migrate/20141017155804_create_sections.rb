class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
<<<<<<< HEAD:db/migrate/20141016001821_create_sections.rb
      

      t.timestamps
=======
      t.integer :teacher_id
      t.string :subject
      t.integer :grade
>>>>>>> 78bf778463134b116fa1d654934b5d91e1bc689e:db/migrate/20141017155804_create_sections.rb
    end
  end
end
