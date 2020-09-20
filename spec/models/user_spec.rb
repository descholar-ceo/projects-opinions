require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:opinions).with_foreign_key(:author_id) }
    it { should have_many(:comments) }
    it { should have_many(:followings).with_foreign_key(:follower_id) }
    it { should have_many(:followeds).through(:followings).source(:followed) }
    it { should have_many(:followers).with_foreign_key(:followed_id).class_name(:Following) }
    it { should have_many(:my_followers).through(:followers).source(:user) }
  end
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(15) }

    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end
  describe 'testing helpers' do
    before :each do
      User.create(email: 'user1@test.tst', username: 'username1',
                  password: 'password', full_name: 'user1password')
      User.create(email: 'user2@test.tst', username: 'username2',
                  password: 'password', full_name: 'user2password')
      User.create(email: 'user3@test.tst', username: 'username3',
                  password: 'password', full_name: 'user3password')
    end

    it 'checks if I follow her' do
      user1 = User.first
      user3 = User.last
      expect(user1.do_i_follow_her?(user3)).to be(false)
    end

    it 'checks who to follow' do
      user1 = User.first
      user3 = User.last
      who_to_follows = user1.who_to_follow(user1)
      expect(who_to_follows.include?(user3)).to be true
    end
  end
end
