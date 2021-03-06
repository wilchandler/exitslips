require 'csv'

CSV.foreach("db/ela_standards.csv") do |row|
  unless row.last == nil || row.first[0] == '('
    standard = Standard.new(subject: "ELA", grade: (/^(?!-)(\d+|K)/).match(row.first).to_s, code: row.first, description: row.last)
    standard.save unless standard.grade.nil?
  end
end

CSV.foreach("db/math_standards.csv") do |row|
  unless row.last == nil || row.first[0] == '('
    standard = Standard.new(subject: "Math", grade: (/^(?!-)(\d+|K)/).match(row.first).to_s, code: row.first, description: row.last)
    standard.save unless standard.grade.nil?
  end
end

teacher = Teacher.create!(first_name: "Casey", last_name: "Cumbow", password: "boom1234", email: "case-eee@yahoo.com")
math = Section.create!(name: "5th Period Math", teacher: teacher, subject: "Math", grade: "4" )
math2 = Section.create!(name: "4th Period Math", teacher: teacher, subject: "Math", grade: "4" )
english = Section.create!(name: "3rd Period Math", teacher: teacher, subject: "Math", grade: "4" )
english2 = Section.create!(name: "1st Period English", teacher: teacher, subject: "ELA", grade: "4" )

math_smarts = [
  Student.new(first_name: "Grace", last_name: "Hopper", email: "student1@yahoo.com", password: "12345678"),
  Student.new(first_name: "Marie", last_name: "Curie", email: "student2@yahoo.com", password: "12345678"),
  Student.new(first_name: "Ada", last_name: "Lovelace", email: "student3@yahoo.com", password: "12345678"),
  Student.new(first_name: "Emmy", last_name: "Noether", email: "student4@yahoo.com", password: "12345678"),
  Student.new(first_name: "Sofia", last_name: "Kovalevskaya", email: "student5@yahoo.com", password: "12345678"),
  Student.new(first_name: "Albert", last_name: "Einstein", email: "student6@yahoo.com", password: "12345678"),
  Student.new(first_name: "Alan", last_name: "Turing", email: "student7@yahoo.com", password: "12345678"),
  Student.new(first_name: "Charles", last_name: "Babbage", email: "student8@yahoo.com", password: "12345678")
]

english_smarts = [
  Student.new(first_name: "Virginia", last_name: "Woolf", email: "student9@yahoo.com", password: "12345678"),
  Student.new(first_name: "David", last_name: "Foster Wallace", email: "student10@yahoo.com", password: "12345678"),
  Student.new(first_name: "Nathanael", last_name: "West", email: "student11@yahoo.com", password: "12345678"),
  Student.new(first_name: "E. M.", last_name: "Forster", email: "student12@yahoo.com", password: "12345678"),
  Student.new(first_name: "Willa", last_name: "Cather", email: "student13@yahoo.com", password: "12345678"),
  Student.new(first_name: "Edith", last_name: "Wharton", email: "student14@yahoo.com", password: "12345678"),
  Student.new(first_name: "Ernest", last_name: "Hemingway", email: "student15@yahoo.com", password: "12345678")
]

science_smarts = [
  Student.new(first_name: "Marie", last_name: "Curie", email: "student16@yahoo.com", password: "12345678"),
  Student.new(first_name: "Isaac", last_name: "Newton", email: "student17@yahoo.com", password: "12345678"),
  Student.new(first_name: "Carl", last_name: "Sagan", email: "student18@yahoo.com", password: "12345678"),
  Student.new(first_name: "Galileo", last_name: "Galilei", email: "student19@yahoo.com", password: "12345678"),
  Student.new(first_name: "Nicola", last_name: "Tesla", email: "student20@yahoo.com", password: "12345678"),
  Student.new(first_name: "Nick", last_name: "Copernicus", email: "student21@yahoo.com", password: "12345678"),
  Student.new(first_name: "Charles", last_name: "Darwin", email: "student22@yahoo.com", password: "12345678")
]

history_smarts = [
  Student.new(first_name: "Adam", last_name: "Smith", email: "student23@yahoo.com", password: "12345678"),
  Student.new(first_name: "Benjamin", last_name: "Franklin", email: "student24@yahoo.com", password: "12345678"),
  Student.new(first_name: "Thomas", last_name: "Jefferson", email: "student25@yahoo.com", password: "12345678"),
  Student.new(first_name: "Thomas", last_name: "Paine", email: "student26@yahoo.com", password: "12345678"),
  Student.new(first_name: "John", last_name: "Locke", email: "student27@yahoo.com", password: "12345678"),
  Student.new(first_name: "Walt", last_name: "Whitman", email: "student28@yahoo.com", password: "12345678"),
  Student.new(first_name: "Charles", last_name: "Rouseau", email: "student29@yahoo.com", password: "12345678")
]

students = (math_smarts + english_smarts).shuffle

students2 = (science_smarts + history_smarts).shuffle

students.sort_by{ |s| s.last_name }.each{ |s| s.save }

students2.sort_by{ |s| s.last_name }.each{ |s| s.save }

students.each do |student|
  math.students << student
  english.students << student
end

students2.each do |student|
  math2.students << student
  english2.students << student
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

english.requirements.each_with_index do |r, i|
  standard = r.standard
  english.quizzes << q = Quiz.create!(
    requirement: r,
    name: "Quiz on #{standard.code}",
    instructions: standard.description
  )

  students.each do |s|
    num_correct = (english_smarts.include? s) ? rand(5..9) : rand(3..8)
    num_correct -= 3 if standard.code == "4.RI.8" && !(s.first_name == "Virginia" || s.first_name == "Willa") # WRITE QUESTIONS!
    num_correct -= 2 if standard.code == "4.RL.4"
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

math2.requirements.each_with_index do |r, i|
  standard = r.standard
  math2.quizzes << q = Quiz.create!(
    requirement: r,
    name: "Quiz on #{standard.code}",
    instructions: standard.description
  )

  students2.each do |s|
    num_correct = (science_smarts.include? s) ? rand(6..10) : rand(4..8)
    num_correct -= 3 if standard.code == "4.NF.3.a" && !(s.first_name == "Isaac" || s.first_name == "Marie") # WRITE QUESTIONS!
    num_correct -= 2 if standard.code == "4.NBT.4"
    num_correct -= 1 if s.first_name == "Carl"
    num_correct += 1 if s.first_name == "Marie"

    Sitting.create!(
      student: s,
      quiz: q,
      possible: 10,
      correct: num_correct,
      graded: true
    )
  end

end

english2.requirements.each_with_index do |r, i|
  standard = r.standard
  english2.quizzes << q = Quiz.create!(
    requirement: r,
    name: "Quiz on #{standard.code}",
    instructions: standard.description
  )

  students2.each do |s|
    num_correct = (history_smarts.include? s) ? rand(5..9) : rand(3..8)
    num_correct -= 3 if standard.code == "4.RI.8" && !(s.first_name == "Isaac" || s.first_name == "Thomas") # WRITE QUESTIONS!
    num_correct -= 2 if standard.code == "4.RL.4"
    num_correct -= 1 if s.first_name == "Charles"
    num_correct += 1 if s.first_name == "Walt"

    Sitting.create!(
      student: s,
      quiz: q,
      possible: 10,
      correct: num_correct,
      graded: true
    )
  end

end


# quiz = Quiz.find_by_name("Quiz on 4.NF.3.a")

# question = Question.create(quiz_id: quiz.id, query: "Wil has 2/6 of a candy bar. Lo has 1/2 of a candy bar. If they put their pieces together, what fraction would they have? Explain how you know. ", question_type: "open_response")


# students.each do |s|
#   sitting = Sitting.create!(
#     student: s,
#     quiz: quiz,
#     possible: 0,
#     correct: 0,
#     graded: false
#   )

#   res = ["3/8 because I added and because I am smart.", "5/6. I know that Wil's candy bar is 2/6 and I know that Lo's candy bar is 1/2 which I know is 3/6. When we put them together, they have 5/6 of a full candy bar.", "I don't know",
#           "5/6 because Wil almost has half a candy bar but he has 1/6 less. So when they put the half and the almost half together they will have 1/6 less than a whole candy bar.", "I think it's like a whole candy bar but I'm not sure.",
#          "five sixths I think because I added."]

#   Answer.create!(
#     question: question,
#     content: res.sample,
#     student: s,
#     sitting: sitting  
#   )
# end
