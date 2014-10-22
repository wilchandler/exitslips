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
    @standard = Standard.create!(subject: "Math", grade: "K", description: "really hard stuff", code: "12345678")
    @requirement = Requirement.create!(standard_id: @standard.id, section_id: @section.id)
  #   students = []
  #   students << student1 = Student.create!(first_name: "student", last_name: "1", email: "tester1@yahoo.com", password: "12345678")
  #   students << student2 = Student.create!(first_name: "student", last_name: "2", email: "tester2@yahoo.com", password: "12345678")
  #   students << student3 = Student.create!(first_name: "student", last_name: "3", email: "tester3@yahoo.com", password: "12345678")
  end


  describe "#Teacher class methods" do 
  	it "should be able to get sections and standards by teacher" do 
  		sections_and_standards = Teacher.get_available_sections_and_standards(1)
  		sections = sections_and_standards[:sections]
  		expect(sections[0].name).to eq("Yabadabadoo") 
  	end
  end


end