require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'relationships' do
    it { should belong_to(:plot) }
  end
end
