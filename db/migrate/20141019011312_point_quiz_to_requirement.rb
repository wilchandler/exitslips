class PointQuizToRequirement < ActiveRecord::Migration
  def change
    rename_column :quizzes, :standard_id, :requirement_id
  end
end
