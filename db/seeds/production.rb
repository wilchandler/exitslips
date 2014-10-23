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
english = Section.create!(name: "3rd Period English", teacher: teacher, subject: "ELA", grade: "4" )

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
    num_correct -= 3 if standard.code == "4.NBT.4" && !(s.first_name == "Ada" || s.first_name == "Grace")
    num_correct -= 2 if standard.code == "4.NF.4"
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
