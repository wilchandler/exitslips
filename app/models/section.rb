class Section < ActiveRecord::Base
 has_many :enrollments
 has_many :students, through: :enrollments
 belongs_to :teacher
 # has_many :quizzes_sections
 has_many :quizzes
 has_many :sittings, through: :quizzes
 has_many :standards, through: :quizzes

end
