class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.string :abbreviation
      t.string :description
      t.integer :section_id

      t.timestamps
    end
  end
end
