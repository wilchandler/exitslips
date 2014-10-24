class Student < User
  has_many :enrollments
  has_many :sections, through: :enrollments
  has_many :answers
  has_many :sittings
  has_many :quizzes, through: :sections

  def calculate_scores_by_standard(args = {})
    scores_by_standard = {}
    args[:requirements].map do |requirement|
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

  def calculate_scores_by_question(args = {})
    scores_by_question = {}
    question_scores = args[:questions].map do |question|
      answers = self.find_answers_by_question(question.id)
      answer = Answer.average_answers(answers)
      # assigning N/A to the answer in case that it's nil. 
      answer = "N/A" if answer == nil
      scores_by_question[question.query] = answer
    end
    scores_by_question
  end


  def find_sittings_by_quiz(quiz_id)
    Sitting.where(student_id: self.id, quiz_id: quiz_id) || []
  end

  def find_answers_by_question(question_id)
    Answer.where(student_id: self.id, question_id: question_id) || []
  end

end
