require 'spec_helper'

describe QuizzesController do
  before(:all) do
    section = Section.create!(teacher_id: 1, name: "test", grade: "K", subject: "Math")
    students = []
    students << student1 = Student.create!(first_name: "student", last_name: "1", email: "tester1@yahoo.com", password: "12345678")
    students << student2 = Student.create!(first_name: "student", last_name: "2", email: "tester2@yahoo.com", password: "12345678")
    students << student3 = Student.create!(first_name: "student", last_name: "3", email: "tester3@yahoo.com", password: "12345678")
    students << student4 = Student.create!(first_name: "student", last_name: "4", email: "tester4@yahoo.com", password: "12345678")
    students << student5 = Student.create!(first_name: "student", last_name: "5", email: "tester5@yahoo.com", password: "12345678")
    students << student6 = Student.create!(first_name: "student", last_name: "6", email: "tester6@yahoo.com", password: "12345678")
    students << student7 = Student.create!(first_name: "student", last_name: "7", email: "tester7@yahoo.com", password: "12345678")
    students << student8 = Student.create!(first_name: "student", last_name: "8", email: "tester8@yahoo.com", password: "12345678")
    students << student9 = Student.create!(first_name: "student", last_name: "9", email: "tester9@yahoo.com", password: "12345678")
    students << student10 = Student.create!(first_name: "student", last_name: "10", email: "tester10@yahoo.com", password: "12345678")
    students << student11 = Student.create!(first_name: "student", last_name: "11", email: "tester11@yahoo.com", password: "12345678")

    students.each { |s| section.students << s }
    quiz = Quiz.create!(name: "MyQuiz", instructions: "My Instructions", section: section, requirement_id: 1)

    students.each do |s|
      next if s == student11

      if s == student1
        Sitting.create!(student: s, quiz: quiz, possible: 20, correct: 0)
      elsif s == student9 # 9 should have highest scores
        Sitting.create!(student: s, quiz: quiz, possible: 20, correct: 20)
      end

      Sitting.create!(student: s, quiz: quiz, possible: 20, correct: s.last_name.to_i)
    end

  end

  let(:quiz) { Quiz.find_by(name: "MyQuiz") }

  describe '#groups' do
    before(:each) { xhr :get, :groups, section_id: 1, id: 1, sort_type: 'homogenous', group_size: '3' }
    let(:json) { JSON.parse(response.body) }

    it 'responds to an AJAX request' do
      expect(json.class).to be Hash
    end

    it 'responds with a key of "groups"' do
      expect(json["groups"]).to_not be nil
    end

    it 'responds with an array of groups' do
      groups = json["groups"]
      expect(groups.count).to be 3
    end

    it 'responds with sorted groups' do
      groups = json["groups"]
      expect(groups[2].sort).to eq ['student 9', 'student 10', 'student 8'].sort
    end

  end

end
