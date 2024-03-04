require "rails_helper"

RSpec.describe Plot, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plant_plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe "validation" do
    it { should validate_presence_of :number}
    it { should validate_presence_of :size }
    it { should validate_presence_of :direction }
  end
end
