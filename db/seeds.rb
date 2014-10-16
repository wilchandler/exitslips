# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
25.times do
  Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)
end


Teacher.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)
Teacher.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "12345678", email: Faker::Internet.email)

3.times do
  Section.create!(teacher_id: 26, name: "Math" )
end

2.times do
  Section.create!(teacher_id: 27, name: Faker::Education.major )
end

students = Student.all
students.each do |s|
  Enrollment.create!(student_id: s.id, section_id: 1 )
end
students.each do |s|
  Enrollment.create!(student_id: s.id, section_id: 2 )
end
students.each do |s|
  Enrollment.create!(student_id: s.id, section_id: 3 )
end
students.each do |s|
  Enrollment.create!(student_id: s.id, section_id: 4 )
end
students.each do |s|
  Enrollment.create!(student_id: s.id, section_id: 5 )
end




sections = Section.all
sections.each do |s|
  SectionTeacher.create!(section_id: s.id, teacher_id: 26 )
  SectionTeacher.create!(section_id: s.id, teacher_id: 27 )
end


  Standard.create!(abbreviation: "CCSS.MATH.CONTENT.4.NBT.A.1", description: "Recognize that in a multi-digit whole number, a ditit in one place represents ten times what it represents in the place to its right.", section_id: 1)
  Standard.create!(abbreviation: "CCSS.MATH.CONTENT.4.NBT.A.2", description: "Read and write multi-digit whole numbers using base-ten numerals, number names, and expanded form. Compare two multi-digit numbers based on the meanings of the digits in each place, using >,=, and < symbols ro record the results of comparisons", section_id: 1)
  Standard.create!(abbreviation: "CCSS.MATH.CONTENT.4.NBT.A.3", description: "Use place value understanding to round multi-digit whole numbers to any place.", section_id: 1)

students = Student.all
students.each do |s|
  Quiz.create!(name: "Numbers & Operations in Base Ten", section_id: 1, student_id: s.id)
end
standards = Standard.all
standards.each do |s|
  Question.create!(query: "Is 153 greater, less than, or equal to 84?", quiz_id: 1, standard_id: s.id, topic: "Place value understanding for multi-digit whole numbers")
end


  Option.create!(content: "greather than", question_id: 1, correct?: true )
  Option.create!(content: "less than", question_id: 1, correct?: false )
  Option.create!(content: "equal to", question_id: 1, correct?: false )

student = Student.all
student.each do |s|
  Answer.create!(question_id: 1, student_id: s.id, content: ["greater","less than"].sample)
  Answer.create!(question_id: 2, student_id: s.id, content: ["greater","less than"].sample)
  Answer.create!(question_id: 3, student_id: s.id, content: ["greater","less than"].sample)

end






