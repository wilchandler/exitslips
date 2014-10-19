
load(Rails.root.join( 'db', 'seeds', "production.rb"))

teacher1 = Teacher.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)

section1 = Section.create!(name: "4th grade Math Section", teacher: teacher1, subject: "Math", grade: "4")
section2 = Section.create!(name: "4th grade ELA Section", teacher: teacher1, subject: "ELA", grade: "4")
section3 = Section.create!(name: "6th Grade Math 1st Hour", teacher: teacher2, subject: "Math", grade: "6")
section4 = Section.create!(name: "6th Grade Math 2nd Hour", teacher: teacher2, subject: "Math", grade: "6")
section5 = Section.create!(name: "6th Grade Math 5th Hour", teacher: teacher2, subject: "Math", grade: "6")

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


  sitting1 = Sitting.create!(student: s, quiz: s1quiz1, possible: 2, correct: 1)
  sitting2 = Sitting.create!(student: s, quiz: s1quiz2, possible: 1, correct: 1)
  sitting3 = Sitting.create!(student: s, quiz: s2quiz1, possible: 1, correct: 1)

  Answer.create!(question_id: q1, content: "4", correct?: true, student: s, sitting: sitting1)
  Answer.create!(question_id: q2, content: "14", correct?: false, student: s, sitting: sitting1)
  Answer.create!(question_id: q3, content: "1054.35", correct?: true, student: s, sitting: sitting2)
  Answer.create!(question_id: q4, content: "Your", correct?: true, student: s, sitting: sitting3)

  s.save
end

teacher2 = Teacher.create!(first_name: "Alexis", last_name: "Lassus", password: "12345678", email: "alassus@gmail.com")

section3 = Section.create!(name: "6th Grade Math 1st Hour", teacher: teacher2, subject: "Math", grade: "6")
section4 = Section.create!(name: "6th Grade Math 2nd Hour", teacher: teacher2, subject: "Math", grade: "6")
section5 = Section.create!(name: "6th Grade Math 5th Hour", teacher: teacher2, subject: "Math", grade: "6")

sixth_standard1 = Standard.find_by_code("6.RP.1")
sixth_standard2 = Standard.find_by_code("6.RP.2")
sixth_standard3 = Standard.find_by_code("6.NS.3")
sixth_standard4 = Standard.find_by_code("6.NS.4")
sixth_standard5 = Standard.find_by_code("6.NS.5")
sixth_standard6 = Standard.find_by_code("6.NS.8")
sixth_standard7 = Standard.find_by_code("6.EE.1")
sixth_standard8 = Standard.find_by_code("6.EE.5")
sixth_standard9 = Standard.find_by_code("6.EE.6")
sixth_standard10 = Standard.find_by_code("6.EE.7")
sixth_standard10 = Standard.find_by_code("6.G.1")


sixth_quiz1 = Quiz.create!(name: "Ratios and Percents I", instructions: "Do these, children!", standard: sixth_standard1, section_id: 3)
q5 = Question.create!(quiz: sixth_quiz1, query: "60% of what number is 45", question_type: "multiple_choice")
Option.create!(question: q5, content: "27", correct?: false)
Option.create!(question: q5, content: "30", correct?: false)
Option.create!(question: q5, content: "60", correct?: false)
Option.create!(question: q5, content: "75", correct?: true)
Option.create!(question: q5, content: "90", correct?: false)
q6 = Question.create!(quiz: sixth_quiz1, query: "What percent of 48 is 60?", question_type: "multiple_choice")
Option.create!(question: q6, content: "65%", correct?: false)
Option.create!(question: q6, content: "80%", correct?: false)
Option.create!(question: q6, content: "85%", correct?: false)
Option.create!(question: q6, content: "90%", correct?: false)
Option.create!(question: q6, content: "125%", correct?: true)
q7 = Question.create!(quiz: sixth_quiz1, query: "What number is 5% of 2000?", question_type: "multiple_choice")
Option.create!(question: q7, content: "50", correct?: false)
Option.create!(question: q7, content: "100", correct?: true)
Option.create!(question: q7, content: "150", correct?: false)
Option.create!(question: q7, content: "200", correct?: false)
Option.create!(question: q7, content: "250", correct?: false)
q8 = Question.create!(quiz: sixth_quiz1, query: "35% of what number is 70?", question_type: "multiple_choice")
Option.create!(question: q8, content: "100", correct?: false)
Option.create!(question: q8, content: "110", correct?: false)
Option.create!(question: q8, content: "150", correct?: false)
Option.create!(question: q8, content: "200", correct?: true)
Option.create!(question: q8, content: "250", correct?: false)
q8 = Question.create!(quiz: sixth_quiz1, query: "35% of what number is 70?", question_type: "multiple_choice")
Option.create!(question: q8, content: "100", correct?: false)
Option.create!(question: q8, content: "110", correct?: false)
Option.create!(question: q8, content: "150", correct?: false)
Option.create!(question: q8, content: "200", correct?: true)
Option.create!(question: q8, content: "250", correct?: false)