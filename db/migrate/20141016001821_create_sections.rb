class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :teacher_id
      t.string :name

      t.timestamps
    end
  end
end
