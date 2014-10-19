class Standard < ActiveRecord::Base
	has_many :quizzes
  has_many :requirements
  has_many :sections, through: :requirements

  validates :subject, :grade, :code, :description, presence: true

  def to_s
    "#{self.code}: #{self.description}"
  end
end
