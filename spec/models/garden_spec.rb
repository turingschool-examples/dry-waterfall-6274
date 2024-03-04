require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe 'plants_harvest_under_100_days' do
    it 'returns plants that take under 100 days' do
      @garden = Garden.create(name: "Example Garden", organic: true)
      @garden2 = Garden.create(name: "Example Garden2", organic: true)

      # Create plots associated with the garden
      @plot1 = Plot.create(number: 1, size: "Medium", direction: "North", garden: @garden)
      @plot2 = Plot.create(number: 2, size: "Large", direction: "East", garden: @garden)
      @plot3 = Plot.create(number: 2, size: "Large", direction: "East", garden: @garden2)
      @plot4 = Plot.create(number: 2, size: "Large", direction: "East", garden: @garden2)
  
      # Create plants with different harvest times
      @plant1 = Plant.create(name: "Tomato Plant", description: "Red fruit", days_to_harvest: 60) #will appear 
      @plant2 = Plant.create(name: "Lettuce Plant", description: "Leafy green", days_to_harvest: 30) #will apear 
      @plant3 = Plant.create(name: "Carrot plant", description: "Root vegetable", days_to_harvest: 120) #will not appear 
      @plant4 = Plant.create(name: "Cucumber Plant", description: "Green vegetable", days_to_harvest: 99) #will appear 
      @plant5 = Plant.create(name: "Chili", description: "Green vegetable", days_to_harvest: 40)
      @plant6 = Plant.create(name: "Grape", description: "Green vegetable", days_to_harvest: 134)
  
      # Associate plants with plots using PlotPlant
      PlotPlant.create(plot: @plot1, plant: @plant1)
      PlotPlant.create(plot: @plot1, plant: @plant2)
      PlotPlant.create(plot: @plot1, plant: @plant3)
      PlotPlant.create(plot: @plot1, plant: @plant4)
  
      PlotPlant.create(plot: @plot2, plant: @plant3)
      PlotPlant.create(plot: @plot2, plant: @plant4)
      PlotPlant.create(plot: @plot2, plant: @plant1)
      PlotPlant.create(plot: @plot2, plant: @plant2)

      PlotPlant.create(plot: @plot3, plant: @plant5)
      PlotPlant.create(plot: @plot4, plant: @plant6)

      expect(@garden.plants_harvest_under_100_days).to eq([@plant1,@plant2,@plant4])
      expect(@garden2.plants_harvest_under_100_days).to eq([@plant5])
    end
  end
end