require 'rails_helper'


describe 'Login' do
  it 'should login' do
    visit '/login'

    User.create(email: 'email@email.com',
                password: 'password')

    fill_in 'login[email]', with: 'email@email.com'
    fill_in 'login[password]', with: 'password'
    click_button 'Log In'

    expect(current_path).to eq('/')
    expect(page).to have_content('Successfully logged in!')
  end
  it 'should fail login' do
    visit '/login'

    User.create(email: 'email@email.com',
                password: 'password')

    fill_in 'login[email]', with: 'email@email.com'
    fill_in 'login[password]', with: '1234'
    click_button 'Log In'

    expect(page).to have_content('Incorrect email or password, try again.')
  end
  it 'should log out' do
    visit '/login'

    User.create(email: 'email@email.com',
                password: 'password')

    fill_in 'login[email]', with: 'email@email.com'
    fill_in 'login[password]', with: 'password'
    click_button 'Log In'

    click_on 'Log Out'
    expect(current_path).to eq('/login')
    expect(page).to have_content('Logged out!')
  end
end
