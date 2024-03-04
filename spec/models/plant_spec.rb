require 'rails_helper'

RSpec.describe Plant, type: :model do
  before(:each) do 
      @garden = Garden.create!(name: "Larry's Garden", organic: true)

      @plot_1 = @garden.plots.create(number: 1, size: "large", direction: "west")
      @plot_2 = @garden.plots.create(number: 2, size: "small", direction: "east")

      @plant_1 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 5)
      @plant_2 = Plant.create!(name: "Sunflower", description: "red", days_to_harvest: 115)

      PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
      PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_2.id)
      PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
  end 
  

  describe 'relationships' do
    it { should have_many :plot_plants }
    it { should have_many(:plots).through(:plot_plants) }
    it { should have_many(:gardens).through(:plots) }
  end

  describe 'class methods' do  
    it '.unique_plants_harvested_in_one_hundred' do
      expect(Plant.unique_plants_harvested_in_one_hundred).to eq([@plant_1])
      expect(Plant.unique_plants_harvested_in_one_hundred).to_not eq([@plant_2])
    end
  end
end
