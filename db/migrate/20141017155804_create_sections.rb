class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.integer :teacher_id
    end
  end
end
