class Teacher < User
  has_many :section_teachers
  has_many :sections, through: :section_teachers
  has_many :quizzes, through: :sections

end
