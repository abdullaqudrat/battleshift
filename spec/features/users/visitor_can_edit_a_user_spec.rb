require 'rails_helper'

feature 'User Edit' do
  context 'As a visitor' do
    scenario 'I navigate to the uer edit page' do
      new_email = 'new_email@email.com'
      VCR.use_cassette("users") do
        visit '/users'
      end

      VCR.use_cassette('users_edit') do
        within '#user-1' do
          click_on 'Edit'
        end
    end

    VCR.use_cassette('users_post_email_edit', :allow_unused_http_interactions => false) do
        fill_in :email, with: new_email
        click_on 'Submit'

        expect(current_path).to eq('/users')
        expect(page).to have_content("Successfully updated Josiah Bartlet")
        expect(page).to have_content(new_email)
      end
    end
  end
end
