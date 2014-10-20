require 'spec_helper'

RSpec.describe Quiz, :type => :model do
  it { should belong_to :requirement }
  it { should have_many :sittings }
  it { should have_many :students }
  it { should belong_to :section }
  it { should have_many :questions }
  it { should have_many :answers }
  it { should have_many :options }

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
      if s.id == 1
        Sitting.create!(student: s, quiz: quiz, possible: 15, correct: 0)
        Sitting.create!(student: s, quiz: quiz, possible: 15, correct: 2)
      elsif s.id == 9 # 9 should have highest scores
        Sitting.create!(student: s, quiz: quiz, possible: 15, correct: 9)
        Sitting.create!(student: s, quiz: quiz, possible: 15, correct: 15)
      elsif s.id != 11 # 11 should have lowest score (no sittings)
        Sitting.create!(student: s, quiz: quiz, possible: 15, correct: s.last_name.to_i)
      end
    end

    # ORDERING (high to low): 9, 10, 8, 7, 6, 5, 4, 3, 2, 1, 11
  end
  let(:quiz) { Quiz.find_by(name: "MyQuiz") }


  describe "#group_by_quiz_scores" do
    it 'returns an array of groups' do
      groups = quiz.group_by_quiz_scores(3, :random)
      expect(groups.count).to be 3
    end

    it 'returns groups of specified size (or +1 if remainder < number of groups)' do
      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(2, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 2
        expect(groups[1].count).to be 2
        expect(groups[2].count).to be 2
        expect(groups[3].count).to be 2
        expect(groups[4].count).to be 3
      end

      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(3, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 3
        expect(groups[1].count).to be 4
        expect(groups[2].count).to be 4
      end

      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(5, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 5
        expect(groups[1].count).to be 6
      end

    end

    it 'returns groups of specified size (or -1 if remainder > number of groups)' do
      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(4, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 3
        expect(groups[1].count).to be 4
        expect(groups[2].count).to be 4
      end

      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(6, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 5
        expect(groups[1].count).to be 6
      end

    end

    it 'returns two groups of equal size if requested size > half of students size' do
      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(7, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 5
        expect(groups[1].count).to be 6
      end

      [:random, :heterogenous, :homogenous].each do |sort_type|
        groups = quiz.group_by_quiz_scores(9, sort_type)
        groups = groups.sort_by { |g| g.count }
        expect(groups[0].count).to be 5
        expect(groups[1].count).to be 6
      end

    end
  end


end
