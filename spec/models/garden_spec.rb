require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  before(:each) do
    @garden_tu = Garden.create!(name: "Turing Community Garden", organic: true)

    @plot_east = @garden_tu.plots.create!(number: 25, size: "Large", direction: "East")
    @plot_west = @garden_tu.plots.create!(number: 10, size: "Medium", direction: "West")

    @plant_pepper = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
    @plant_cilantro = Plant.create!(name: "Cilantro", description: "Needs lots of water", days_to_harvest: 20)
    @plant_cherry = Plant.create!(name: "Cherry", description: "dry soil better", days_to_harvest: 60)
    @plant_tomatoe = Plant.create!(name: "Tomatoe", description: "Needs lots of water", days_to_harvest: 5)
    @plant_orange = Plant.create!(name: "Orange", description: "Light lover", days_to_harvest: 150)

    @plot_east.plants << @plant_pepper << @plant_tomatoe << @plant_orange
    @plot_west.plants << @plant_cherry << @plant_cilantro << @plant_tomatoe
  end

  describe "instance methods" do
    describe "unique_plant_list" do
      it "returns an array of unique plants" do
        expect(@garden_tu.unique_plant_list).to eq([@plant_pepper, @plant_cilantro, @plant_cherry, @plant_tomatoe, @plant_orange])
      end
    end

    describe "upcoming_harvest_list" do
      it "returns a collection of unique plants that will be harvested in less than 100 days" do
        expect(@garden_tu.upcoming_harvest_list).to eq([@plant_pepper, @plant_cilantro, @plant_cherry, @plant_tomatoe])
      end
    end
  end
end