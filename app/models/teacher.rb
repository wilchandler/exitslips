class Teacher < User
  has_many :sections
  has_many :quizzes, through: :sections
  has_many :standards, through: :sections

  def self.get_available_sections_and_standards(teacher_id)
    # returns a hash for use in Rails
    # contains: sections and 2d array for use in Rails select form
    # these are combined to allow eager loading

    sections = Section.where(teacher_id: teacher_id).includes(:standards)
    standards = Set.new
    sections.each do |section|
      section.standards.each { |standard| standards << standard }
    end

    standard_options = standards.to_a.map { |s| ["#{s.code}", s.id] }
    {sections: sections, standards: standard_options}
  end
end
