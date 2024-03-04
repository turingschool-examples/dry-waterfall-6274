require "rails_helper"

RSpec.describe Plot, type: :model do
  describe 'relationships' do
    it { should have_many(:plant_plots) }
    it { should have_many(:plots).through(:plant_pots) }
  end
end