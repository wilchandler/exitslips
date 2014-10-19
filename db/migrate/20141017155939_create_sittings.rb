class CreateSittings < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.integer :student_id
      t.integer :quiz_id
      t.integer :possible
      t.integer :correct?
    end
  end
end
