require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many :plants }
  end

  describe "#harvest_under_hundred_days" do
    before do
      @garden_1 = Garden.create!(name: "Barry's Garden", organic: true)

      @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "North")
      @plot_2 = @garden_1.plots.create!(number: 2, size: "Medium", direction: "South")
      @plot_3 = @garden_1.plots.create!(number: 3, size: "Small", direction: "East")
      @plot_4 = @garden_1.plots.create!(number: 4, size: "Medium", direction: "West")
      @plot_5 = @garden_1.plots.create!(number: 5, size: "Large", direction: "North")
  
      @wheat = Plant.create!(name: "Wheat", description: "Standard sun and water requirements for wheat", days_to_harvest: 180)
      @spinach = Plant.create!(name: "Spinach", description: "Standard sun and water requirements for spinach", days_to_harvest: 60)
      @broccoli = Plant.create!(name: "Broccoli", description: "Standard sun and water requirements for broccoli", days_to_harvest: 120)
      @tomato = Plant.create!(name: "Tomato", description: "Standard sun and water requirements for tomatoes", days_to_harvest: 30)
      @carrot = Plant.create!(name: "Carrot", description: "Standard sun and water requirements for carrots", days_to_harvest: 100)
      @eggplant = Plant.create!(name: "Eggplant", description: "Standard sun and water requirements for eggplants", days_to_harvest: 60)
  
      PlotPlant.create!(plot: @plot_1, plant: @wheat)
      PlotPlant.create!(plot: @plot_1, plant: @spinach)
      PlotPlant.create!(plot: @plot_1, plant: @tomato)
      PlotPlant.create!(plot: @plot_1, plant: @carrot)
      PlotPlant.create!(plot: @plot_1, plant: @eggplant)
  
      PlotPlant.create!(plot: @plot_2, plant: @spinach)
      PlotPlant.create!(plot: @plot_2, plant: @carrot)
      PlotPlant.create!(plot: @plot_2, plant: @eggplant)
  
      PlotPlant.create!(plot: @plot_3, plant: @wheat)
      PlotPlant.create!(plot: @plot_3, plant: @tomato)
  
      PlotPlant.create!(plot: @plot_4, plant: @broccoli)
      PlotPlant.create!(plot: @plot_4, plant: @wheat)
  
      PlotPlant.create!(plot: @plot_5, plant: @wheat)
      PlotPlant.create!(plot: @plot_5, plant: @carrot)
      PlotPlant.create!(plot: @plot_5, plant: @eggplant)
    end

    it "returns a unique list of plants that take less than 100 days to harvest only" do
      plants = @garden_1.harvest_under_hundred_days

      expect(plants).to eq([@spinach, @tomato, @eggplant])
    end
  end
end