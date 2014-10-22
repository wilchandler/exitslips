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
    @section = Section.create!(teacher_id: 1, name: "Yabadabadoo", grade: "K", subject: "Math")
    @standard = Standard.create!(subject: "Math", grade: "K", description: "really hard stuff", code: "K.RL.1")
    @requirement = Requirement.create!(standard_id: @standard.id, section_id: @section.id)
    @student1 = Student.create!(first_name: "student", last_name: "1", email: "tester1@yahoo.com", password: "12345678")
    @quiz = Quiz.create!(name: "MyQuiz", instructions: "My Instructions", section: @section.id, requirement_id: 1)

    @sitting = Sitting.create!(student_id: 1, quiz_id: 1, possible: 50, correct: 40)
  end


  describe "get_available_sections_and_standards method" do 
  	it "should be able to get sections by teacher" do 
  		sections_and_standards = Teacher.get_available_sections_and_standards(1)
  		sections = sections_and_standards[:sections]
  		expect(sections[0].name).to eq("Yabadabadoo") 
  		expect(sections[0].subject).to eq("Math") 
  		expect(sections[0].grade).to eq("K") 
  	end

  	it "should be able to get standards by teacher" do 
			sections_and_standards = Teacher.get_available_sections_and_standards(1)
			standards = sections_and_standards[:standards]
			expect(standards[0][0]).to eq("K.RL.1") 
  	end
  end

  describe "get mastery_for_all_sections method" do 
  	it "should be able to get section mastery" do 
  		


end