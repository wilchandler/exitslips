class AddIndexesToStandards < ActiveRecord::Migration
  def change
    add_index :standards, [:subject, :grade]
    add_index :standards, :grade
  end
end
