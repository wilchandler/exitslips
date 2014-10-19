class Teacher < User
  has_many :sections
  has_many :quizzes, through: :sections
  has_many :standards, through: :sections

end
