class Requirement < ActiveRecord::Base
  belongs_to :section
  belongs_to :standard
  has_many :quizzes

  validates_uniqueness_of :standard_id, scope: :section_id
end
