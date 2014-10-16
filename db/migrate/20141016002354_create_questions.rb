class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :query
      t.integer :quiz_id
      t.integer :standard_id
      t.string :topic

      t.timestamps
    end
  end
end
