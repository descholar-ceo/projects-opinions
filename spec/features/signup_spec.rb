require 'rails_helper'

RSpec.describe 'Registering a new user', type: :feature do
  it 'Registers a user if I provide correct information' do
    visit '/users/sign_up'
    within('form') do
      fill_in 'Full name', with: 'user 4 names'
      fill_in 'Username', with: 'user4'
      fill_in 'Email', with: 'user4@projects.opinions'
      fill_in 'Password', with: 'user4password'
      fill_in 'Password confirmation', with: 'user4password'
    end
    click_button 'Sign up'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  it 'Refuses register if I provided a wrong confirm password' do
    visit '/users/sign_up'
    within('form') do
      fill_in 'Full name', with: 'user 5 names'
      fill_in 'Username', with: 'user5'
      fill_in 'Email', with: 'user5@projects.opinions'
      fill_in 'Password', with: 'user5password'
      fill_in 'Password confirmation', with: 'user5pass'
    end
    click_button 'Sign up'
    expect(current_path).to eq(users_path)
    expect(page).to have_content("Password confirmation doesn't match Passwor")
  end
end
