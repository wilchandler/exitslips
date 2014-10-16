class Quiz < ActiveRecord::Base
	belongs_to :section
	has_many :questions
	belongs_to :student, class_name: "User"

  accepts_nested_attributes_for :questions, allow_destroy: true
end
