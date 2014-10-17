class CreateSittings < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.integer :student_id
      t.integer :quiz_id
    end
  end
end
