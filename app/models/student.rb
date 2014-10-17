class Student < User
  has_many :enrollments
  has_many :sections, through: :enrollments
  has_many :answers
  has_many :sittings
  has_many :quizzes, through: :sittings
end
