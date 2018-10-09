require 'rails_helper'

feature 'User index' do
  context 'As a visitor' do
    scenario 'visits the user index page' do
      VCR.use_cassette("users") do

      user = create(:user)
      visit '/users'

      expect(page).to have_content(user.name)
      expect(page).to have_content('Barney Rubble')
      end

    end
  end
end
