class Section < ActiveRecord::Base
 before_save :passcode_generator
 has_many :enrollments
 has_many :students, through: :enrollments
 belongs_to :teacher
 has_many :quizzes
 has_many :sittings, through: :quizzes
 has_many :standards, through: :quizzes

 def passcode_generator
 	self.passcode = ('a'..'z').to_a.shuffle[0,8].join
 end

end
