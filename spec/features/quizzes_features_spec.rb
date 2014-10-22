require 'spec_helper'

feature "Student_show" do
  before(:each) do
    visit new_user_session_path
    @liberty = Student.create!(first_name: "liberty", last_name: "valance", email: "valance@mail.com", password: "12345678")
    @sec = Section.create!(name: "Math")
    Enrollment.create!(student_id: @liberty.id, section_id: @sec.id)
    Quiz.create!(name: "Numbers & Operations in Base Ten", section_id: @sec.id)

    fill_in "user_email", with: "valance@mail.com"
    fill_in "user_password", with: "12345678"
    first('input[type="submit"]').click
  end

  context "student is logged in" do
  end

  context "welcome page for student" do
    xit "shows the current student's name" do
      expect(page).to have_content("Welcome, liberty valance")
    end

    xit "should show the sections for current student" do
      expect(page).to have_content("Math")
    end

    xit "should show the quiz name" do
      expect(page).to have_content("Numbers & Operations in Base Ten")
    end

    xit "should show the quiz name underneath the section" do
      ("Math").should appear_before("Numbers")
    end
  end
end



