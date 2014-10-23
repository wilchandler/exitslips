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
  

      standard = Standard.create!(subject: "ELA", grade: "5th", code: "boo", description: "hard stuff")
      standard = Standard.create!(subject: "Math", grade: "5th", code: "boo", description: "really hard stuff")




      teacher = Teacher.create!(first_name: "Casey", last_name: "Cumbow", password: "boom1234", email: "case-eee@yahoo.com")
      math = Section.create!(name: "5th Period Math", teacher: teacher, subject: "Math", grade: "4" )
      english = Section.create!(name: "3rd Period English", teacher: teacher, subject: "ELA", grade: "4" )

      math_smarts = [
        Student.new(first_name: "Grace", last_name: "Hopper", email: "student1@yahoo.com", password: "12345678"),
        Student.new(first_name: "Marie", last_name: "Curie", email: "student2@yahoo.com", password: "12345678")
      ]

      english_smarts = [
        Student.new(first_name: "Virginia", last_name: "Woolf", email: "student9@yahoo.com", password: "12345678"),
        Student.new(first_name: "David", last_name: "Foster Wallace", email: "student10@yahoo.com", password: "12345678")
      ]

      students = (math_smarts + english_smarts).shuffle

      students.sort_by{ |s| s.last_name }.each{ |s| s.save }

      students.each do |student|
        math.students << student
        english.students << student
      end

      math.requirements.each_with_index do |r, i|
        standard = r.standard
        math.quizzes << q = Quiz.create!(
          requirement: r,
          name: "Quiz on #{standard.code}",
          instructions: standard.description
        )

        students.each do |s|
          num_correct = (math_smarts.include? s) ? rand(6..10) : rand(4..8)
          num_correct -= 3 if standard.code == "4.NF.3.a" && !(s.first_name == "Ada" || s.first_name == "Grace") # WRITE QUESTIONS!
          num_correct -= 2 if standard.code == "4.NBT.4"
          num_correct -= 1 if s.first_name == "Ernest"
          num_correct += 1 if s.first_name == "Virginia"

          Sitting.create!(
            student: s,
            quiz: q,
            possible: 10,
            correct: num_correct,
            graded: true
          )
        end

      end


  end


  context "get_available_sections_and_standards method" do 
  	it "should be able to get sections by teacher" do 
  		teacher = Teacher.first
      sections_and_standards = Teacher.get_available_sections_and_standards(teacher.id)
      sections = sections_and_standards[:sections]
      expect(sections[0].name).to eq("3rd Period English") 
      expect(sections[0].subject).to eq("ELA") 
      expect(sections[0].grade).to eq("4") 
  	end

  	xit "should be able to get standards by teacher" do 
      teacher = Teacher.first
      sections_and_standards = Teacher.get_available_sections_and_standards(teacher.id)
			standards = sections_and_standards[:standards]
			expect(sections_and_standards).to eq("K.RL.1") 
  	end

  	it "should be able to get section mastery" do 
      teacher = Teacher.first
      @masteries = teacher.mastery_for_all_sections
      expect(@masteries[0][:section]).to eq("3rd Period English")
    end
  end
  		

end