class CreateStandards < ActiveRecord::Migration
  def change
    create_table :standards do |t|
      t.string :type
      t.string :grade
      t.string :code
      t.text :description
    end
  end
end
