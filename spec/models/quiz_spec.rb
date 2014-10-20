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

    it 'groups randomly' do
      groups1 = quiz.group_by_quiz_scores(4, :random)
      groups2 = quiz.group_by_quiz_scores(4, :random)
      groups3 = quiz.group_by_quiz_scores(4, :random)
      groups4 = quiz.group_by_quiz_scores(4, :random)

      [groups1, groups2, groups3, groups4].each do |groups|
        groups.each { |group| group.sort! }
        groups.sort!
      end

      match = false
      if groups1.flatten == groups2.flatten
        if groups2.flatten == groups3.flatten
          if groups3.flatten == groups4.flatten
            match = true
          end
        end
      end

      expect(match).to be false
    end

    it 'groups heterogenously when not enough students for full groups (+1 in some)' do
      # ORDERING (high to low): 9, 10, 8, 7, 6, 5, 4, 3, 2, 1, 11

      groups = quiz.group_by_quiz_scores(2, :heterogenous)
      expect(groups[0].sort).to eq ['student 5', "student 9", 'student 11'].sort
      expect(groups[1].sort).to eq ["student 10", 'student 1'].sort
      expect(groups[2].sort).to eq ["student 8", 'student 2'].sort
      expect(groups[3].sort).to eq ["student 7", 'student 3'].sort
      expect(groups[4].sort).to eq ["student 6", 'student 4'].sort

      groups = quiz.group_by_quiz_scores(3, :heterogenous)
      expect(groups[0].sort).to eq ['student 9', 'student 11', 'student 7', 'student 3'].sort
      expect(groups[1].sort).to eq ['student 10', 'student 1', 'student 6', 'student 4'].sort
      expect(groups[2].sort).to eq ['student 8', 'student 2', 'student 5'].sort
    end

    it 'groups heterogenously when not enough students for full groups (-1 in some)' do
      groups = quiz.group_by_quiz_scores(4, :heterogenous)
      expect(groups[0].sort).to eq ['student 9', 'student 11', 'student 7', 'student 3'].sort
      expect(groups[1].sort).to eq ['student 10', 'student 1', 'student 6', 'student 4'].sort
      expect(groups[2].sort).to eq ['student 8', 'student 2', 'student 5'].sort

      groups = quiz.group_by_quiz_scores(6, :heterogenous)
      expect(groups[0].sort).to eq ['student 9', 'student 8', 'student 6', 'student 4', 'student 2', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 10', 'student 7', 'student 5', 'student 3', 'student 1'].sort
    end

    it 'groups heterogenously and accounts for requests of group size more than half of section size' do
      groups = quiz.group_by_quiz_scores(7, :heterogenous)
      expect(groups[0].sort).to eq ['student 9', 'student 8', 'student 6', 'student 4', 'student 2', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 10', 'student 7', 'student 5', 'student 3', 'student 1'].sort
    end

    it 'groups homogenously when not enough for full groups (-1 in some)' do
      # ORDERING (high to low): 9, 10, 8, 7, 6, 5, 4, 3, 2, 1, 11

      groups = quiz.group_by_quiz_scores(4, :homogenous)
      expect(groups[0].sort).to eq ['student 3', 'student 2', 'student 1', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 7', 'student 6', 'student 5', 'student 4'].sort
      expect(groups[2].sort).to eq ['student 9', 'student 10', 'student 8'].sort
    end

    it 'groups homogenously (+1 in some)' do
      # ORDERING (high to low): 9, 10, 8, 7, 6, 5, 4, 3, 2, 1, 11

      groups = quiz.group_by_quiz_scores(3, :homogenous)
      expect(groups[0].sort).to eq ['student 3', 'student 2', 'student 1', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 7', 'student 6', 'student 5', 'student 4'].sort
      expect(groups[2].sort).to eq ['student 9', 'student 10', 'student 8'].sort
    end

    it 'groups homogenously' do
      groups = quiz.group_by_quiz_scores(6, :homogenous)
      expect(groups[0].sort).to eq ['student 5', 'student 4', 'student 3', 'student 2', 'student 1', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 9', 'student 10', 'student 8', 'student 7', 'student 6'].sort

      groups = quiz.group_by_quiz_scores(8, :homogenous)
      expect(groups[0].sort).to eq ['student 5', 'student 4', 'student 3', 'student 2', 'student 1', 'student 11'].sort
      expect(groups[1].sort).to eq ['student 9', 'student 10', 'student 8', 'student 7', 'student 6'].sort
    end

    it 'groups homogenously on even groups' do
      2.times { Student.last.destroy } # Now there are only 9 students
      groups = quiz.group_by_quiz_scores(3, :homogenous)
      expect(groups[0].sort).to eq ['student 3', 'student 2', 'student 1'].sort
      expect(groups[1].sort).to eq ['student 6', 'student 5', 'student 4'].sort
      expect(groups[2].sort).to eq ['student 9', 'student 8', 'student 7'].sort
    end

    it 'groups heterogenously on even groups' do
      2.times { Student.last.destroy } # Now there are only 9 students

      groups = quiz.group_by_quiz_scores(3, :heterogenous)
      expect(groups[0].sort).to eq ['student 9', 'student 4', 'student 1'].sort
      expect(groups[1].sort).to eq ['student 8', 'student 5', 'student 2'].sort
      expect(groups[2].sort).to eq ['student 7', 'student 6', 'student 3'].sort
    end

  end


end
