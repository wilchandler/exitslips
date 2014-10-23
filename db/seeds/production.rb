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
  Student.create!(first_name: "Grace", last_name: "Hopper", email: "student1@yahoo.com", password: "12345678")
  Student.create!(first_name: "Marie", last_name: "Curie", email: "student2@yahoo.com", password: "12345678")
  Student.create!(first_name: "Ada", last_name: "Lovelace", email: "student3@yahoo.com", password: "12345678")
  Student.create!(first_name: "Emmy", last_name: "Noether", email: "student4@yahoo.com", password: "12345678")
  Student.create!(first_name: "Sofia", last_name: "Kovalevskaya", email: "student5@yahoo.com", password: "12345678")
  Student.create!(first_name: "Albert", last_name: "Einstein", email: "student6@yahoo.com", password: "12345678")
  Student.create!(first_name: "Alan", last_name: "Turing", email: "student7@yahoo.com", password: "12345678")
  Student.create!(first_name: "Charles", last_name: "Babbage", email: "student8@yahoo.com", password: "12345678")
]

english_smarts = [
  Student.create!(first_name: "Virginia", last_name: "Woolf", email: "student9@yahoo.com", password: "12345678")
  Student.create!(first_name: "David", last_name: "Foster Wallace", email: "student10@yahoo.com", password: "12345678")
  Student.create!(first_name: "Nathanael", last_name: "West", email: "student11@yahoo.com", password: "12345678")
  Student.create!(first_name: "E. M.", last_name: "Forster", email: "student12@yahoo.com", password: "12345678")
  Student.create!(first_name: "Willa", last_name: "Cather", email: "student13@yahoo.com", password: "12345678")
  Student.create!(first_name: "Edith", last_name: "Wharton", email: "student14@yahoo.com", password: "12345678")
  Student.create!(first_name: "Ernest", last_name: "Hemingway", email: "student15@yahoo.com", password: "12345678")
]

students = (math_smarts + english_smarts).shuffle

students.each do |student|
  math.students << student
  english.students << student
end

math.requirements.each do |r|
  math.quizzes << q = Quiz.create!(
    requirement: r,
    name: "Quiz on #{r.code}",
    instructions: r.description
  )

  students.each do |s|
    Sitting.create!(
      student: s,
      quiz: q,
      possible: 10,
      correct: math_smarts.include? s ? rand(6..10) : rand(4..8)
    )
  end

end

