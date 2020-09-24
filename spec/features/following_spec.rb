require 'rails_helper'

RSpec.describe 'Following and unfollowing a user', type: :feature do
  before :each do
    User.create(email: 'user6@test.nz', password: 'user6password', username: 'user6', full_name: 'user 6 user')
    User.create(email: 'user7@test.nz', password: 'user7password', username: 'user7', full_name: 'user 7 user')

    visit '/users/sign_in'
    within('form') do
      fill_in 'Email', with: 'user6@test.nz'
      fill_in 'Password', with: 'user6password'
    end
    click_button 'Log in'
  end

  it 'Follow a user, when follow link has been clicked' do
    visit root_path
    click_link 'Follow'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('user 6 user')
    expect(page).not_to have_content('Failed to follow that user, try again!')
  end

  it 'visits a given user\'s profile' do
    user1 = User.last
    visit user_path(user1.id)
    expect(current_path).to eq(user_path(user1.id))
    expect(page).to have_content('user 7 user')
    expect(page).to have_link('Follow')
  end

  it 'Unfollowing a user' do
    user1 = User.last
    visit user_path(user1.id)
    click_link 'Follow'
    visit user_path(user1.id)
    click_link 'Unfollow'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('user 6 user')
  end
end
