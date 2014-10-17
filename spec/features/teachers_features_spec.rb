
require 'spec_helper'


describe "Teacher" do

  before :each do
  	teacher = FactoryGirl.create(:teacher)
  	login_as(teacher, :scope => :teacher)
  	student = Student.create!(first_name: "Larry", last_name: "Sommers", email: "Larry@mail.com", password: "12345678")
  	section = Section.create!(name: "Ms. McTeacher's class" )
    Enrollment.create!(student_id: student.id, section_id: section.id)

  end

  context "is logged in" do

  	it "Shows the current teacher's first and last name" do
  		expect(page).to have_content("Teacher McTeacher")
  	end

  	it "Shows the sections that are associated with that teacher." do
  		expect(page).to have_content("Ms. McTeacher's Class")
  	end

  	it "Allows the teacher to see her section's mastery." do
  		expect(page).to have_content("Mastery")
  	end

  	it "Allows the teacher to create a quiz" do
  		expect(page)to have_link("Create a Quiz", href: "/quizzes/new")
  	end

  end

  context "creates a quiz" do

  	it "has a field to title the quiz" do

  	end

  	it "has a field to write a question" do
  	end

  	it "has a field to write the answer" do
  	end

  	it "has a link to add a question" do

  	end

  	it "has a link to add an option" do

  	end

  	it "has an option to change the type of question" do
  	end

  	it "has an option to assign the question to multiple sections" do
  	end

  end


end

