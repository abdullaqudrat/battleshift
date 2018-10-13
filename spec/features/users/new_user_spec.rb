require 'rails_helper'

describe 'New User Creation' do
    #As a guest user
  context 'As a guest user' do
    scenario 'I should be able to create a new user' do
      #When I visit "/"
      visit '/'
      #And I click "Register"
      click_on 'Register'
      #Then I should be on "/register"
      expect(current_path).to eq('/register')
      #And when I fill in an email address (required)
      #fill_in :email, with: 'email@email.com'
      fill_in 'user[email]', with: 'email@email.com'
      #And I fill in name (required)
      fill_in 'user[name]', with: 'Peter'
      #And I fill in password and password confirmation (required)
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      #And I click submit
      click_on 'Submit'
      #Then I should be redirected to "/dashboard"
      expect(current_path).to eq('/dashboard')
      #And I should see a message that says "Logged in as <SOME_NAME>"
      expect(page).to have_content('Logged in as Peter')
      #And I should see "This account has not yet been activated. Please check your email."
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
