class Requirement < ActiveRecord::Base
  belongs_to :section
  belongs_to :standard
  has_many :quizzes
end
