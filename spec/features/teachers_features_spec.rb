
require 'spec_helper'

# describe "Teacher" do
#   before :each do
#   	teacher = FactoryGirl.create(:teacher)
#   	login_as(teacher, :scope => :teacher)
#   end

feature "Student_show" do
  before(:each) do
    visit new_user_session_path
    @liberty = Teacher.create!(first_name: "liberty", last_name: "valance", email: "valance@mail.com", password: "12345678")
    @sec = Section.create!(name: "Math")
    SectionTeacher.create!(section_id: @sec.id, teacher_id: @liberty.id )
    fill_in "user_email", with: "valance@mail.com"
    fill_in "user_password", with: "12345678"
    first('input[type="submit"]').click
  end

  context "teacher is logged in" do
  end

  context "Welcome page for Teacher" do
    it "should display name of teacher logged in" do
      save_and_open_page
      expect(page).to have_content("Welcome, liberty valance")
    end
  end
end

