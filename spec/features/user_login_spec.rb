feature 'Registration' do
  context "registration" do
    # before(:each) do
    #   visit root_path
    #   click_link 'Sign Up'
    #   fill_in 'user_first_name', with: "Liberty"
    #   fill_in 'user_last_name', with: "Valance"
    # end

    it "can fill out registration form and click sign up" do
    end
  end

  context "logging in" do
    before(:each) do
      visit new_user_session_path
      @liberty = Teacher.create!(first_name: "liberty", last_name: "valance", email: "valance@mail.com", password: "12345678")
    end

    it "will show errors for invalid email" do
      fill_in 'user_email', with: "test@mail.com "
      fill_in 'user_password', with: "12345678"
      expect(page).to_not have_content("valance@mail.com")
      first('input[type="submit"]').click
      expect(page).to have_content "Invalid email or password"
    end

    it "redirects to show page for teacher when logged in" do
      fill_in 'user_email', with: "valance@mail.com"
      fill_in 'user_password', with: "12345678"
      first('input[type="submit"]').click
      expect(page).to_not have_content("Sign In")
      expect(page).to have_content("Welcome")
    end

    it "shows a logout button if user is logged in" do
      fill_in 'user_email', with: "valance@mail.com"
      fill_in 'user_password', with: "12345678"
      first('input[type="submit"]').click
      expect(page).to have_content("Sign Out")
    end
  end
end
