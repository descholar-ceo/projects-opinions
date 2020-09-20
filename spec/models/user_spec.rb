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
    it { should validate_uniqueness_of(:username) }
    it {
      should validate_length_of(:username)
        .is_at_least(3)
        .is_at_most(15)
        .with_message('Username should be between 3 to 15 characters')
    }

    it { should validate_presence_of(:full_name) }
    it {
      should validate_length_of(:full_name)
        .is_at_least(3)
        .is_at_most(50)
        .with_message('Full name should be present, and between 3 to 50 characters')
    }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end
  describe 'testing helpers' do
    let(:user1) do
      User.create(email: 'user1@test.tst', username: 'username1',
                  password: 'password', full_name: 'user1password')
    end
    let(:user2) do
      User.create(email: 'user2@test.tst', username: 'username2',
                  password: 'password', full_name: 'user2password')
    end
    let(:user3) do
      User.create(email: 'user3@test.tst', username: 'username3',
                  password: 'password', full_name: 'user3password')
    end
    it 'checks if I follow her' do
      expect(user2.do_i_follow_her?(user1)).to be(false)
    end

    it 'checks who to follow' do
      user1.followings.create(followed: user2)
      who_to_follows = user1.who_to_follow(user1)
      #   puts "The gotten whotofollow is #{user1.followeds}"
      expect(who_to_follows.include?(user3)).to be true
    end
  end
end
