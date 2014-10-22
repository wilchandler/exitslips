load(Rails.root.join( 'db', 'seeds', "production.rb"))

# ************************************* #
# ------------------------------------- #
# ************* TEACHER 1 ************* #
# ------------------------------------- #
# ************************************* #

teacher = Teacher.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)

section1 = Section.create!(name: "4th grade Math Section", teacher: teacher, subject: "Math", grade: "4")
section2 = Section.create!(name: "4th grade ELA Section", teacher: teacher, subject: "ELA", grade: "4")

standard1 = Standard.create!(subject: "Math", grade: "4", code: "B.A.4", description: "Do advanced math")
standard2 = Standard.create!(subject: "Math", grade: "4", code: "B.A.5", description: "Do basic math")
standard3 = Standard.create!(subject: "ELA", grade: "4", code: "E.A.5", description: "Learn empathy")

r1 = Requirement.create!(section: section1, standard: standard1)
r2 = Requirement.create!(section: section1, standard: standard2)
r3 = Requirement.create!(section: section2, standard: standard1)

s1quiz1 = Quiz.create!(name: "Advanced Math", instructions: "Do these, children!", section_id: 1, requirement: r1)
q1 = Question.create!(quiz: s1quiz1, query: "What is 2 + 2?", question_type: "multiple_choice")
Option.create!(question: q1, content: "4", correct?: true)
Option.create!(question: q1, content: "22", correct?: false)
q2 = Question.create!(quiz: s1quiz1, query: "What is the square root of 144?", question_type: "multiple_choice")
Option.create!(question: q2, content: "14", correct?: false)
Option.create!(question: q2, content: "12", correct?: true)

s1quiz2 = Quiz.create!(name: "Beginner Math", instructions: "Don't mess it up, children!", section_id: 1, requirement: r2)
q3 = Question.create!(quiz: s1quiz2, query: "What is 13.5 x 78.1?", question_type: "multiple_choice")
Option.create!(question: q3, content: "1054.35", correct?: true)
Option.create!(question: q3, content: "1044.35", correct?: false)

s2quiz1 = Quiz.create!(name: "Advanced grammar", instructions: "Do these, children!", section_id: 2, requirement: r3)
q4 = Question.create!(quiz: s2quiz1, query: "I want to tell Suzie her brother smells bad.  How do I refer to her brother possessively?", question_type: "multiple_choice")
Option.create!(question: q4, content: "You're", correct?: false)
Option.create!(question: q4, content: "Your", correct?: true)

10.times do
  s = Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)
  s.sections << section1
  s.sections << section2


  sitting1 = Sitting.create!(student: s, quiz: s1quiz1, possible: 2, correct: 1)
  sitting2 = Sitting.create!(student: s, quiz: s1quiz2, possible: 1, correct: 1)
  sitting3 = Sitting.create!(student: s, quiz: s2quiz1, possible: 1, correct: 1)

  Answer.create!(question_id: 1, content: "4", correct: true, student_id: s.id, sitting: sitting1)
  Answer.create!(question_id: 2, content: "14", correct: false, student_id: s.id, sitting: sitting1)
  Answer.create!(question_id: 3, content: "1054.35", correct: true, student_id: s.id, sitting: sitting2)
  Answer.create!(question_id: 4, content: "Your", correct: true, student_id: s.id, sitting: sitting3)

  s.save
end



# ************************************* #
# ------------------------------------- #
# ************* TEACHER 2 ************* #
# ------------------------------------- #
# ************************************* #



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

sdx = Student.all

sdx.each do |s|
  10.times do 
    Answer.create!(question_id: [q1, q2, q3].sample, content: "Testing123", correct: [true, false].sample, student_id: s.id)
  end
end


section14 = Section.create!(name: "Testing woohoo", teacher: teacher, subject: "Math", grade: "12", passcode: "test123")
