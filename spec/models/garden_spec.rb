require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots)}
  end

  it "returns distinct plants" do
    @garden_1 = Garden.create!(name: "Testgarden", organic: true)
    @garden_2 = Garden.create!(name: "Test2garden", organic: false)

    @plot_1 = Plot.create!(number: 1, size:"small", direction: "east", garden_id: @garden_1.id)
    @plot_2 = Plot.create!(number: 2, size:"meduim", direction: "west", garden_id: @garden_2.id)

    @plant_1 = Plant.create!(name: "flower", description:"prefers desert", days_to_harvest: 120)
    @plant_2 = Plant.create!(name: "grass", description:"prefers water", days_to_harvest: 10)

    @plotplant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
    @plotplant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)

    expect(@garden_1.distinct_plants.first).to eq(@plant_2)

  end
end