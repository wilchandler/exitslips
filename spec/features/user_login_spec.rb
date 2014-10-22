require 'spec_helper'

feature 'Registration' do
  
  context "logging in" do
    before(:each) do
      visit new_user_session_path
      @liberty = Teacher.create!(first_name: "liberty", last_name: "valance", email: "valance@mail.com", password: "12345678")
    end

    xit "will show errors for invalid email" do
      fill_in 'user_email', with: "test@mail.com "
      fill_in 'user_password', with: "12345678"
      expect(page).to_not have_content("valance@mail.com")
      first('input[type="submit"]').click
      expect(page).to have_content "Invalid email or password"
    end

    xit "redirects to show page for teacher when logged in" do
      fill_in 'user_email', with: "valance@mail.com"
      fill_in 'user_password', with: "12345678"
      first('input[type="submit"]').click
      expect(page).to_not have_content("Sign In")
      expect(page).to have_content("Welcome")
    end

    xit "shows a logout button if user is logged in" do
      fill_in 'user_email', with: "valance@mail.com"
      fill_in 'user_password', with: "12345678"
      first('input[type="submit"]').click
      expect(page).to have_content("Sign Out")
    end
  end
end
