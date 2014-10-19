
load(Rails.root.join( 'db', 'seeds', "production.rb"))

teacher = Teacher.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)

section1 = Section.create!(name: "4th grade Math Section", teacher: teacher, subject: "Math", grade: "4")
section2 = Section.create!(name: "4th grade ELA Section", teacher: teacher, subject: "ELA", grade: "4")

standard1 = Standard.create!(subject: "Math", grade: "4", code: "B.A.4", description: "Do advanced math")
standard2 = Standard.create!(subject: "Math", grade: "4", code: "B.A.5", description: "Do basic math")
standard3 = Standard.create!(subject: "ELA", grade: "4", code: "E.A.5", description: "Learn empathy")

s1quiz1 = Quiz.create!(name: "Advanced Math", instructions: "Do these, children!", standard: standard1, section_id: 1)
q1 = Question.create!(quiz: s1quiz1, query: "What is 2 + 2?", question_type: "multiple_choice")
Option.create!(question: q1, content: "4", correct?: true)
Option.create!(question: q1, content: "22", correct?: false)
q2 = Question.create!(quiz: s1quiz1, query: "What is the square root of 144?", question_type: "multiple_choice")
Option.create!(question: q2, content: "14", correct?: false)
Option.create!(question: q2, content: "12", correct?: true)

s1quiz2 = Quiz.create!(name: "Beginner Math", instructions: "Don't mess it up, children!", standard: standard2, section_id: 1)
q3 = Question.create!(quiz: s1quiz2, query: "What is 13.5 x 78.1?", question_type: "multiple_choice")
Option.create!(question: q3, content: "1054.35", correct?: true)
Option.create!(question: q3, content: "1044.35", correct?: false)

s2quiz1 = Quiz.create!(name: "Advanced grammar", instructions: "Do these, children!", standard: standard3, section_id: 2)
q4 = Question.create!(quiz: s2quiz1, query: "I want to tell Suzie her brother smells bad.  How do I refer to her brother possessively?", question_type: "multiple_choice")
Option.create!(question: q4, content: "You're", correct?: false)
Option.create!(question: q4, content: "Your", correct?: true)


10.times do
  s = Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)
  s.sections << section1
  s.sections << section2


  sitting1 = Sitting.create!(student: s, quiz: s1quiz1, possible: 2, correct?: 1)
  sitting2 = Sitting.create!(student: s, quiz: s1quiz2, possible: 1, correct?: 1)
  sitting3 = Sitting.create!(student: s, quiz: s2quiz1, possible: 1, correct?: 1)

  Answer.create!(question_id: q1, content: "4", correct?: true, student: s, sitting: sitting1)
  Answer.create!(question_id: q2, content: "14", correct?: false, student: s, sitting: sitting1)
  Answer.create!(question_id: q3, content: "1054.35", correct?: true, student: s, sitting: sitting2)
  Answer.create!(question_id: q4, content: "Your", correct?: true, student: s, sitting: sitting3)

  s.save
end
