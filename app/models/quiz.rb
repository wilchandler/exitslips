class Quiz < ActiveRecord::Base
 belongs_to :requirement
 has_many :sittings
 has_many :students, through: :sittings
 belongs_to :section
 has_many :questions
 has_many :answers, through: :questions
 has_many :options, through: :questions

  accepts_nested_attributes_for :questions, allow_destroy: true

  def process_quiz_form(args = {})
    self.update_attributes(
      name: args[:name],
      instructions: args[:instructions]
    )
    questions = args[:questions_attributes].values
    questions.each do |question_data|
      Question.process_quiz_form(self.id, question_data)
    end
  end

  def calculate_scores_by_question
    questions = self.questions
    students = self.students
    scores = {}

    students.each do |student|
      quiz_results = student.calculate_scores_by_question({
        questions: self.questions,
        quiz_id: self.id
      })
      scores[student.id] = quiz_results
    end
    scores
  end

  def question_ids_and_contents
    question_bindings = {}
    self.questions.each { |q| question_bindings[q.id] = q.query }
    question_bindings
  end

  def group_by_quiz_scores(group_size, sort_type)
    grouping_args = make_groups(group_size)
    scores = gather_student_scores
    scores = scores.sort_by { |s| s[1] } unless sort_type == :random
    grouping_args[:scores] = scores.map { |s| s[0] }

    if sort_type == :random
      return group_randomly(grouping_args)
    elsif sort_type == :homogenous
      return group_homogenously(grouping_args)
    elsif sort_type == :heterogenous
      return group_heterogenously(grouping_args)
    end
  end

  def make_groups(group_size)
    section_size = self.section.students.count

    if group_size > section_size / 2
      groups = Array.new(2) { [] }
      group_size = section_size / 2
    else
      groups = Array.new(section_size / group_size) { [] }
    end

    remainder = section_size % group_size

    # if groups of 4 is requested from 11,
    # this will return groups of size 4, 4, 3
    # instead of groups of size 5, 6
    if remainder > groups.count
      groups << []
      group_size -= 1
    end

    { groups: groups, remainder: remainder, group_size: group_size }
  end

  def gather_student_scores
    students = self.section.students
    scores = Array.new
    students.each do |student|
      sittings = Sitting.where(student_id: student.id, quiz_id: self.id)
      average_score = Sitting.average_sittings(sittings)
      scores << [student.full_name, average_score || 0]
    end
    scores
  end

  def group_randomly(args = {})
    groups = args[:groups]
    scores = args[:scores]
    until scores.empty?
      groups.each do |group|
        pop = scores.delete_at(rand(scores.count))
        group << pop unless pop.nil?
      end
    end
    groups
  end

  def group_homogenously(args = {})
    groups = args[:groups]
    remainder = args[:remainder]
    group_size = args[:group_size]
    scores = args[:scores]

    groups.each do |group|
      if remainder > 0
        scores.shift(group_size + 1).each { |student| group << student}
        remainder -= 1
      else
        scores.shift(group_size).each { |student| group << student}
      end
    end
    groups
  end

  def group_heterogenously(args = {})
    groups = args[:groups]
    remainder = args[:remainder]
    group_size = args[:group_size]
    scores = args[:scores]

    while scores.length >= 2 * group_size
      groups.each do |group|
        group << scores.pop
        group << scores.shift
      end
    end

    until scores.empty?
      groups.each do |group|
        shift = scores.shift
        group << shift unless shift.nil?
      end

      groups.each do |group|
        pop = scores.pop
        group << pop unless pop.nil?
      end
    end

    groups
  end

  def get_ungraded_answers
    @questions = Question.where(quiz_id: self.id, question_type: "open_response").includes(:answers)
    ungraded_answers = {}
    @questions.each do |q|
      answers_for_question = []
      q.answers.each do |a|
        answers_for_question << a if a.correct.nil?
      end
      ungraded_answers[q.query] = answers_for_question
    end
    ungraded_answers
  end

end
