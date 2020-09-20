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
  #   describe 'validation' do
  #     it 'when name is empty, saving in the db fails' do
  #       user = User.new(email: 'usertest@test.tst', password: 'password').save
  #       expect(user).to be(false)
  #     end
  #     it 'when name has length greater than 20, saving in the db fails' do
  #       user = User.new(email: 'usertest@test.tst', password: 'password', name: 'userpasswordtotestistooloong').save
  #       expect(user).to be(false)
  #     end
  #     it 'when name has length less than 20, saving in the db succeed' do
  #       user = User.new(email: 'usertest@test.tst', password: 'password', name: 'userpasswordtotest').save
  #       expect(user).to be(true)
  #     end
  #   end
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
