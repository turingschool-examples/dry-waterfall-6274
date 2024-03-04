require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe 'instance methods' do
    before(:each) do
      @garden1 = Garden.create!(name: "Majorelle Garden", organic: false)

      @plot1 = Plot.create!(number: 13, size: "Small", direction: "West", garden_id: @garden1.id)
      @plot2 = Plot.create!(number: 23, size: "Medium", direction: "East", garden_id: @garden1.id)
      @plot3 = Plot.create!(number: 36, size: "Large", direction: "North", garden_id: @garden1.id)

      @plant1 = Plant.create!(name: "Rose", description: "Delicate Flower", days_to_harvest: 50)
      @plant2 = Plant.create!(name: "Basil", description: "Fragrant Herb", days_to_harvest: 75)
      @plant3 = Plant.create!(name: "Strawberries", description: "Juicy Fruit", days_to_harvest: 65)
      @plant4 = Plant.create!(name: "Zucchini", description: "Summer Squash", days_to_harvest: 60)
      @plant5 = Plant.create!(name: "Sunflower", description: "Tall bright yellow flower", days_to_harvest: 105)
      @plant6 = Plant.create!(name: "Lavender", description: "Perenial Herb", days_to_harvest: 120)
      @plant7 = Plant.create!(name: "Daisies", description: "Cheerful Flower", days_to_harvest: 70)

      @plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
      @plot_plant2 = PlotPlant.create!(plot: @plot1, plant: @plant2)
      @plot_plant3 = PlotPlant.create!(plot: @plot2, plant: @plant1)
      @plot_plant4 = PlotPlant.create!(plot: @plot2, plant: @plant5)
      @plot_plant5 = PlotPlant.create!(plot: @plot3, plant: @plant3)
      @plot_plant6 = PlotPlant.create!(plot: @plot3, plant: @plant2)
      @plot_plant7 = PlotPlant.create!(plot: @plot3, plant: @plant4)
    end

    it 'uniq_plants' do
      expect(@garden1.uniq_plants.sort).to eq([@plant1, @plant2, @plant3, @plant4].sort)
    end
  end
end