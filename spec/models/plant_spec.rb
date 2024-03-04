require 'rails_helper'

RSpec.describe Plant, type: :model do
    describe 'relationships' do
        it { should have_many(:plot_plants) }
        it { should have_many(:plots).through(:plot_plants) }
    end

    describe "class method" do
        describe ".harvest_under_100_days" do
            it "returns plants with days to harvest under 100" do 
                garden = Garden.create!(name: "Turing Community Garden", organic: true)

                plot1 = garden.plots.create!(number: 25, size: "Large", direction: "East")
                plot2 = garden.plots.create!(number: 26, size: "Small", direction: "West")

                plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
                plant2 = Plant.create!(name: "Cucumber", description: "Green and refreshing", days_to_harvest: 50)
                plant3 = Plant.create!(name: "Tomato", description: "Red and juicy", days_to_harvest: 110)

                plot_plant1 = PlotPlant.create!(plot: plot1, plant: plant1)
                plot_plant2 = PlotPlant.create!(plot: plot2, plant: plant2)
                
                plants_under_100_days = Plant.harvest_under_100_days
        
                expect(plants_under_100_days).to include(plant1)
                expect(plants_under_100_days).to include(plant2)
                expect(plants_under_100_days).not_to include(plant3)
            end
        end
    end
end