require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plant_plots).through(:plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe "instances methods" do 
    describe "#harvestable_plants" do 
      it "selects distinct plants from a garden that has less than 100 days harvest time" do 
        garden_1 = Garden.create!(name: "The best garden", organic: true)
        garden_2 = Garden.create!(name: "The worst garden", organic: false)
  
        plot_1 = garden_1.plots.create!(number: 10, size: "100 acres", direction: "North")
        plot_2 = garden_2.plots.create!(number: 5, size: "1 acre", direction: "South")
  
        plant_1 = Plant.create!(name: "Lily's", description: "Bright Yellow", days_to_harvest: 25)
        plant_4 = Plant.create!(name: "Don't see me", description: "Bright Yellow", days_to_harvest: 102)
        plant_2 = Plant.create!(name: "Sun Flower", description: "Barely Alive", days_to_harvest: 40)
  
        PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_2.id)

        expect(garden_1.harvestable_plants).to eq([plant_1])
        expect(garden_2.harvestable_plants).to eq([plant_1, plant_2])
        expect(garden_1.harvestable_plants.count).to eq(garden_1.harvestable_plants.distinct.count)
        expect(garden_2.harvestable_plants.count).to eq(garden_2.harvestable_plants.distinct.count) 
      end
    end
  end
end