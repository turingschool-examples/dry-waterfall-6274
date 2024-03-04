require "rails_helper"

RSpec.describe PlantPlot, type: :model do
  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should belong_to(:plot) }
  end

  describe "validations" do
    it { should validate_presence_of :plant_id }
    it { should validate_presence_of :plot_id }
  end
end
