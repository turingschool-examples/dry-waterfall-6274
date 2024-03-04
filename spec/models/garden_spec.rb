require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  before (:each) do
    @garden_1 = Garden.create!(name: "Jack's Garden", organic: false) 

    @plant_1 = Plant.create!(name: "Rose", description: "Red and thorny", days_to_harvest: 60)
    @plant_2 = Plant.create!(name: "Tulip", description: "Yellow and not thorny", days_to_harvest: 45)
    @plant_3 = Plant.create!(name: "Daisy", description: "White and small", days_to_harvest: 55)
    @plant_4 = Plant.create!(name: "Arugula", description: "Green and leafy", days_to_harvest: 101)

    @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "South")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "Small", direction: "East")

    @plot_plant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
    @plot_plant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
    @plot_plant_3 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
    @plot_plant_4 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_2.id)
    @plot_plant_5 = PlotPlant.create!(plant_id: @plant_4.id, plot_id: @plot_2.id)
  end

  describe 'Instance Methods' do 
    describe '#unique_fast_growing_plants' do
      it 'returns a unique list of all plants in plots that belong to the garden and have a time to harvest under 100 days' do
        expect(@garden_1.unique_fast_growing_plants).to match_array([@plant_1, @plant_2, @plant_3])
        expect(@garden_1.unique_fast_growing_plants.include?(@plant_4)).to eq(false)
      end
    end
  end
end