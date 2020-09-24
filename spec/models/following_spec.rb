require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'Associations' do
    it { should belong_to(:user).with_foreign_key(:follower_id).class_name(:User) }
    it { should belong_to(:followed).with_foreign_key(:followed_id).class_name(:User) }
  end
end
