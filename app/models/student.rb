class Student < User
  has_many :enrollments
  has_many :sections, through: :enrollments
  has_many :answers
  has_many :sittings
  has_many :quizzes, through: :sittings

  def calculate_scores_by_standard(args = {})
    # return array with scores for all standards passed in (in context of section)
    scores_by_standard = {}
    args[:requirements].map do |requirement|
      # quizzes = Quiz.where(standard: standard.id, section: args[:section_id])
      # debugger
      quizzes = requirement.quizzes
      quiz_scores = quizzes.map do |quiz|
        sittings = self.find_sittings_by_quiz(quiz.id)
        Sitting.average_sittings(sittings)
      end
      quiz_scores.compact!

      return nil if quiz_scores.empty?
      score_by_standard = (quiz_scores.inject(:+).to_f / quiz_scores.length.to_f).round
      scores_by_standard[requirement.standard.code] = score_by_standard
    end
    scores_by_standard
  end

  def find_sittings_by_quiz(quiz_id)
    Sitting.where(student_id: self.id, quiz_id: quiz_id) || []
  end






    # FIND a section
    # FIND that section's standards
    # FIND that section's students
    # FOR EACH student
      # FOR EACH standard
        # FIND quizzes WHERE: standard = standard & section = section
        # FOR EACH of ^
        # FIND that quiz's sittings
        # FIND sittings WHERE student = student & quiz = quiz

        # FOR EACH of ^
          # FOR EACH of the sittings, sum the amount correct
          # FOR EACH of the sittings, sum the amound possible
          # RETURN a percentage or nil

end
