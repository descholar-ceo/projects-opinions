require 'rails_helper'

RSpec.describe Opinion, type: :model do
  describe 'Associations' do
    it { should belong_to(:user).with_foreign_key(:author_id) }
    it { should have_many(:comments) }
  end
end
