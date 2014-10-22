require 'spec_helper'

feature "Section_show" do
  before(:each) do
    visit new_user_session_path
    liberty = Teacher.create!(first_name: "liberty", last_name: "valance", email: "valance@mail.com", password: "12345678")
    sec = Section.create!(name: "Math", teacher_id: liberty.id)
    fill_in "user_email", with: "valance@mail.com"
    fill_in "user_password", with: "12345678"
    first('input[type="submit"]').click
  end

  context "Welcome page for Teacher" do
    it "should display name of teacher logged in" do
      expect(page).to have_content("Welcome, liberty valance")
    end
    it "should display Sections of the teacher" do
      expect(page).to have_content("Math")
    end
    it "should put All Sections before Latest Quiz on page" do
      ("Mastery of Standards vs. Sections").should appear_before("Latest Quiz")
    end

  end
end

