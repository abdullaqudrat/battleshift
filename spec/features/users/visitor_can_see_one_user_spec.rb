require 'rails_helper'

feature 'User Show' do
  context 'As a visitor' do
    scenario 'visits the user show page' do
      VCR.use_cassette("user") do
        user = create(:user)
        visit '/users/1'

        expect(page).to have_content(user.name)
      end
    end
  end
end
