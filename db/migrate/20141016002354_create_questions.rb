class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :query
      t.integer :quiz_id
      t.integer :standard_id
      t.string :type

      t.timestamps
    end
  end
end
