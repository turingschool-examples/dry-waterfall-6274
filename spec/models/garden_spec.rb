require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  before(:each) do
    @garden_1 = Garden.create(name: 'Example Garden', organic: true)

    @plant_1 = Plant.create(name: 'Tomato', description: 'Red and juicy', days_to_harvest: 100)
    @plant_2 = Plant.create(name: 'Lettuce', description: 'Green and crisp', days_to_harvest: 30)

    @plot_1 = Plot.create(number: 1, size: 'Medium', direction: 'North', garden: @garden_1)

    @plan_plot_1 = PlantPlot.create(plant: @plant_1, plot: @plot_1)
    @plan_plot_2 =PlantPlot.create(plant: @plant_2, plot: @plot_1)
  end

  describe "class#methods" do
    it "a unique plant that is under 100 days" do
      expect(@garden_1.unique_plants_under_100_days).to include(@plant_2)
    end
  end
end