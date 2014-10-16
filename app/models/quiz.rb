class Quiz < ActiveRecord::Base
	belongs_to :section
	has_many :questions
	belongs_to :student, class_name: "User"
end
