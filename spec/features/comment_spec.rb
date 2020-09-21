require 'rails_helper'

RSpec.describe 'A user can be able to comment the opinion', type: :feature do
  before :each do
    User.create(email: 'user8@test.nz', password: 'user8password', username: 'user8', full_name: 'user 8 user')

    visit '/users/sign_in'
    within('form') do
      fill_in 'Email', with: 'user8@test.nz'
      fill_in 'Password', with: 'user8password'
    end
    click_button 'Log in'
    visit opinions_path
    within('form') do
      fill_in 'Do you have some opinion on your mind?', with: 'This is a post one'
    end
    click_button 'Send opinion'
  end

  it 'comment on an opinion' do
    within('#new_comment') do
      fill_in 'comment_body', with: 'This is comment one'
    end
    click_button 'Comment'
    expect(current_path).to eq(opinions_path)
    expect(page).to have_content('This is comment one')
  end

  it 'refuses to comment on an opinion is the comment body is empty' do
    click_button 'Comment'
    expect(current_path).to eq(opinions_path)
    expect(page).to have_content('Body can\'t be blank')
  end
end
