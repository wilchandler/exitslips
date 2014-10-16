class Section < ActiveRecord::Base
	has_many :section_teachers
	has_many :teachers, through: :section_teachers, class_name: "User"
	has_many :standards
	has_many :quizzes
end
