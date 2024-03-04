require 'rails_helper'

RSpec.describe PlotPlant, type: :model do

  describe 'relationships' do
    it { should belong_to :plant}
    it { should belong_to :plot}
  end

  before(:each) do
    @garden_1 = Garden.create!(name: "Jack's Garden", organic: false) 

    @plant_1 = Plant.create!(name: "Rose", description: "Red and thorny", days_to_harvest: 60)
    @plant_2 = Plant.create!(name: "Tulip", description: "Yellow and not thorny", days_to_harvest: 45)
    @plant_3 = Plant.create!(name: "Daisy", description: "White and small", days_to_harvest: 55)

    @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "South")
    @plot_2 = @garden_1.plots.create!(number: 2, size: "Small", direction: "East")

    @plot_plant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
    @plot_plant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
    @plot_plant_3 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
    @plot_plant_4 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_2.id) 
  end

  describe 'instance methods' do
    describe '#plant_name' do
      it 'returns the name of the plant associated with the plot_plant' do
        expect(@plot_plant_1.plant_name).to eq("Rose")
        expect(@plot_plant_2.plant_name).to eq("Tulip")
        expect(@plot_plant_3.plant_name).to eq("Tulip")
        expect(@plot_plant_4.plant_name).to eq("Daisy")
      end
    end
  end
end