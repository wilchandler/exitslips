class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :teacher_id
      t.string :subject
      t.string :grade
      t.string :passcode
      t.timestamps
    end
  end
end



      

    


