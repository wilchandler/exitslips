class User < ActiveRecord::Base
	has_many :section_teachers, foreign_key: :teacher_id
	has_many :enrollments, foreign_key: :student_id
	has_many :sections, through: :enrollments
	has_many :sections, through: :section_teachers
	has_many :answers, foreign_key: :student_id
	has_many :quizzes, foreign_key: :student_id
end
