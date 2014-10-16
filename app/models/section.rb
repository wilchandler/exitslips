class Section < ActiveRecord::Base
	has_many :section_teachers
	has_many :teachers, through: :section_teachers
	has_many :standards
	has_many :quizzes
  has_many :enrollments
  has_many :students, through: :enrollments
end
