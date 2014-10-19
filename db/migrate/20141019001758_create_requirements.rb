class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :standard_id
      t.integer :section_id

      t.timestamps
    end

    add_index :requirements, [:standard_id, :section_id]
    add_index :requirements, :section_id
  end
end
