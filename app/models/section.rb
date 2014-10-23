class Section < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments
  belongs_to :teacher
  has_many :quizzes
  has_many :sittings, through: :quizzes
  has_many :requirements
  has_many :standards, through: :requirements

  before_create { generate_passcode }
  after_create { generate_requirements}

  def generate_passcode
    self.passcode = ('a'..'z').to_a.sample(7).join
  end

  def generate_requirements
    standards = Standard.where(grade: self.grade, subject: self.subject).pluck(:id)
    standards.each do |standard_id|
      Requirement.create(standard_id: standard_id, section_id: self.id)
    end
  end

  def calculate_scores_by_standard(key_type = :id)
    requirements = self.requirements
    students = self.students
    scores = {}


    students.each do |student|
      s = student.calculate_scores_by_standard({
        requirements: requirements,
        section_id: self.id
      })
      if key_type == :id
        scores[student.id] = s
      elsif key_type == :name
        scores[student.full_name] = s
      end
    end
    scores
  end

  def to_csv(options = {})
    require 'csv'
    scores = calculate_scores_by_standard(:name)
    standard_codes = self.standards.pluck(:code)

    CSV.generate(options) do |csv|
      csv << ["name"] + standard_codes
      scores.each do |name, results|
        csv << [name] + results.values_at(*standard_codes)
      end
    end
  end

end
