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
    it { should validate_length_of(:username).is_at_least(3).is_at_most(15) }

    it { should validate_presence_of(:full_name) }
    it { should validate_length_of(:full_name).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:email).is_at_least(3).is_at_most(50) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20)}
  end
  #   describe 'testing helpers' do
  #     let(:user) { User.create(email: 'usertesthelpers@test.tst', password: 'password', name: 'userpasswordtotest') }
  #     let(:friend) do
  #       User.create(email: 'friendtesthelpers@test.tst',
  #                   password: 'password',
  #                   name: 'friendpasswordtotest')
  #     end
  #     it 'confirms the friend request' do
  #       user.friendships.new(friend_id: friend.id, status: false).save
  #       friend.confirm_request(user)
  #       expect(friend.a_friend?(user)).to be(true)
  #     end

  #     it 'rejecting friendhip request' do
  #       user.friendships.new(friend_id: friend.id, status: false).save
  #       friend.reject_request(user)
  #       expect(friend.inverse_friendships.include?(user)).to be false
  #     end
  #   end
end
