require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should allow_value('https://www.google.com/').for(:url) }
    it { should_not allow_value('www.google.com/').for(:url) }
  end

  describe 'associations' do
    it { should have_many(:visits).dependent(:destroy) }
  end
end
