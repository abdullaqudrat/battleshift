require 'rails_helper'

describe 'New User Creation' do
  context 'As a guest user' do
    scenario 'I should be able to create a new user' do
      visit '/'

      click_on 'Register'

      expect(current_path).to eq('/register')

      fill_in 'user[email]', with: 'email@email.com'
      fill_in 'user[name]', with: 'Peter'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'Submit'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Logged in as Peter')
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
    scenario 'I should be able to activate account after registration email sent' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


      visit "/users/#{user.id}/activate?key=#{user.api_key}"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Thank you! Your account is now activated.")
      expect(page).to have_content("Status: true")
    end
    scenario 'I should be able to activate account after registration email sent' do
      user = create(:user)
      user_2 = create(:user, api_key: 'notthecorrectkey', email: '1234')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


      visit "/users/#{user.id}/activate?key=#{user_2.api_key}"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Wrong User Token")
      expect(page).to have_content("Status: false")
    end
  end
end
