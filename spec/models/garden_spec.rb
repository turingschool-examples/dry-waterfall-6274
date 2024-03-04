require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe '#plant_list' do
    before(:each) do
      @mac_garden = Garden.create!(name: "Mac Garden", organic: true)
      
      @green_plot = Plot.create!(number: 9, size: "Medium", garden_id: @mac_garden.id)
      @blue_plot = Plot.create!(number: 13, size: "Small", garden_id: @mac_garden.id)

      @bell_pepper = Plant.create!(name: "Bell Pepper", description: "Green Bell Pepper", days_to_harvest: 100)
      @dill = Plant.create!(name: "Dill", description: "Dill", days_to_harvest: 10)
      @tomato = Plant.create!(name: "Tomato", description: "Large tomatoes", days_to_harvest: 30)
      @kale = Plant.create!(name: "Kale", description: "Red Kale", days_to_harvest: 101)

      @plant_plot1 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @bell_pepper.id)
      @plant_plot2 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @dill.id)
      @plant_plot3 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @tomato.id)
      @plant_plot4 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @bell_pepper.id)
    end
    it 'retrieves list of plants with days to harvest less than 100' do
      expect(@mac_garden.plant_list).to eq([@dill, @tomato])
    end
  end
end