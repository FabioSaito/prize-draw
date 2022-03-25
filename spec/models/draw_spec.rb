require 'rails_helper'

RSpec.describe Draw, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:winner) }
  end
end
