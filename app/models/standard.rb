class Standard < ActiveRecord::Base
	has_many :quizzes
  has_many :sections, through: :quizzes

  validates :subject, :grade, :code, :description, presence: true
end
