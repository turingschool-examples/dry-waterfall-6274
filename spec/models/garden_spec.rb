require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots)}
  end

  it "returns distinct plants" do
    @garden_1 = Garden.create!(name: "Testgarden", organic: true)
    @garden_2 = Garden.create!(name: "Test2garden", organic: false)

    @plot_1 = Plot.create!(number: 1, size:"small", direction: "east", garden_id: @garden_1.id)
    @plot_2 = Plot.create!(number: 2, size:"meduim", direction: "west", garden_id: @garden_1.id)

    @plant_1 = Plant.create!(name: "flower", description:"prefers desert", days_to_harvest: 120)
    @plant_2 = Plant.create!(name: "grass", description:"prefers water", days_to_harvest: 10)
    @plant_3 = Plant.create!(name: "tree", description:"prefers nothing", days_to_harvest: 12)


    @plotplant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
    @plotplant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
    @plotplant_3 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
    @plotplant_4 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)
    @plotplant_5 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_1.id)
    @plotplant_6 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_2.id)



    distinct_plants = @garden_1.distinct_plants

    expect(distinct_plants.count).to eq(2)
    
    distinct_plants.each do |plant|
      expect(plant.days_to_harvest).to be < 100
    end

    expect(distinct_plants).to match_array([@plant_2, @plant_3])

  end
end