class AddStatusToSitting < ActiveRecord::Migration
  def change
    add_column :sittings, :graded, :boolean
  end
end
