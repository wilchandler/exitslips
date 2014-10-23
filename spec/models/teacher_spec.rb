require 'spec_helper'

RSpec.describe Teacher, :type => :model do
  it { should have_many :sections }
  it { should have_many :quizzes }
  it { should validate_presence_of :password }
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_uniqueness_of :email }


	before(:each) do
		@teacher = Teacher.create!(first_name: "Liberty", last_name: "Valance", email: "yahoo@gmail.com", password: "12345678")
    @section = Section.create!(teacher_id: @teacher.id, name: "Yabadabadoo", grade: "K", subject: "Math")
    @standard = Standard.create!(subject: "Math", grade: "K", description: "really hard stuff", code: "K.RL.1")
    @requirement = Requirement.create!(standard_id: @standard.id, section_id: @section_id)
    @student1 = Student.create!(first_name: "student", last_name: "1", email: "tester1@yahoo.com", password: "12345678")
    @student2 = Student.create!(first_name: "student1", last_name: "2", email: "tester2@yahoo.com", password: "12345678")
    @student3 = Student.create!(first_name: "student2", last_name: "3", email: "tester3@yahoo.com", password: "12345678")
    @enrollment = Enrollment.create!(student_id: @student1.id, section_id: @section.id)
    @quiz = Quiz.create!(name: "MyQuiz", instructions: "My Instructions", section_id: @section.id, requirement_id: @requirement.id)
    @quiz2 = Quiz.create!(name: "MyQuiz2", instructions: "My Instructions", section_id: @section.id, requirement_id: @requirement.id)

    @sitting = Sitting.create!(student_id: @student1.id, quiz_id: @quiz.id, possible: 50, correct: 40, graded: true)
    @sitting2 = Sitting.create!(student_id: @student1.id, quiz_id: @quiz.id, possible: 50, correct: 40, graded: true)

    teacher2 = Teacher.create!(first_name: "Alexis", last_name: "Lassus", password: "12345678", email: "alassus@gmail.com")

    section3 = Section.create!(name: "6th Grade Math 1st Hour", teacher: teacher2, subject: "Math", grade: "6")
    section4 = Section.create!(name: "6th Grade Math 2nd Hour", teacher: teacher2, subject: "Math", grade: "6")
    section5 = Section.create!(name: "6th Grade Math 5th Hour", teacher: teacher2, subject: "Math", grade: "6")

        [section3, section4, section5].each do |section|
          students = Student.all
          students.each { |student| section.students << student }

          section.requirements.each do |requirement|
            next if rand(0..50) == 0

            quiz = Quiz.create!(name: Faker::Lorem.words(3).join(" "), instructions: "Do these, children!", section: section, requirement: requirement)
            students.each do |student|
              n = [1, 2].sample
              n.times { Sitting.create!(student: student, quiz: quiz, possible: 10, correct: rand(4..11)) }
            end

          end

        end

      sections_and_standards = Teacher.get_available_sections_and_standards(1)
      standards = sections_and_standards[:standards]

  end


  context "get_available_sections_and_standards method" do 
  	xit "should be able to get sections by teacher" do 
  		sections_and_standards = Teacher.get_available_sections_and_standards(1)
  		sections = sections_and_standards[:sections]
  		expect(sections[0].name).to eq("Yabadabadoo") 
  		expect(sections[0].subject).to eq("Math") 
  		expect(sections[0].grade).to eq("K") 
  	end

  	xit "should be able to get standards by teacher" do 
      sections_and_standards = Teacher.get_available_sections_and_standards(1)
			standards = sections_and_standards[:standards]
			expect(sections_and_standards).to eq("K.RL.1") 
  	end

  	xit "should be able to get section mastery" do 
      @liberty = Teacher.find_by(first_name: "Liberty").mastery_for_all_sections
      @masteries = @liberty.mastery_for_all_sections
      # expect(masteries[0][:section]).to eq("Yabadabadoo")
      expect(@masteries).to eq("Yabadabadoo")
    end
  end
  		

end