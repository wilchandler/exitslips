class Teacher < User
  has_many :sections
  has_many :quizzes, through: :sections

end

# score
# section details
