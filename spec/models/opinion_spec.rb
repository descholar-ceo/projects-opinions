require 'rails_helper'

RSpec.describe Opinion, type: :model do
  describe 'Associations' do
    it { should belong_to(:user).with_foreign_key(:author_id) }
    it { should have_many(:comments) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(500) }
  end
end
