class User < ActiveRecord::Base

  self.inheritance_column = :user_type
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :enrollments, foreign_key: :student_id
	has_many :sections, through: :enrollments
	# has_many :section_teachers, foreign_key: :teacher_id
	# has_many :sections, through: :section_teachers
	# has_many :answers, foreign_key: :student_id
	# has_many :quizzes, through: :sections

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

end
