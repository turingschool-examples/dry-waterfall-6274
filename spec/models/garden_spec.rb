require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it {should have_many(:plots)}
    it {should have_many(:plot_plants).through(:plots)}
    it {should have_many(:plants).through(:plot_plants)}
  end

  let!(:garden_1) { Garden.create!(name: "Leaf It", organic: true)}
  let!(:garden_2) { Garden.create!(name: "Garden the Plants from Harm", organic: false)}

  let!(:plot_1) { garden_1.plots.create!(number: 1, size: "small", direction: "north")}
  let!(:plot_2) { garden_1.plots.create!(number: 2, size: "medium", direction: "south")}
  let!(:plot_3) { garden_2.plots.create!(number: 3, size: "large", direction: "east")}
  let!(:plot_4) { garden_2.plots.create!(number: 4, size: "x-large", direction: "west")}

  let!(:plant_1) {Plant.create!(name: "Pumpkin", description: "Halloween fun", days_to_harvest: 130)}
  let!(:plant_2) {Plant.create!(name: "Potato", description: "delicious", days_to_harvest: 35)}
  let!(:plant_3) {Plant.create!(name: "Cabbage", description: "rabbit food", days_to_harvest: 20)}
  let!(:plant_4) {Plant.create!(name: "Carrot", description: "better rabbit food", days_to_harvest: 101)}
  let!(:plant_5) {Plant.create!(name: "Tomato", description: "always taken off my sandwiches", days_to_harvest: 52)}

  let!(:plot_plant_1) {PlotPlant.create!(plot: plot_1, plant: plant_1)}
  let!(:plot_plant_2) {PlotPlant.create!(plot: plot_1, plant: plant_2)}

  let!(:plot_plant_3) {PlotPlant.create!(plot: plot_2, plant: plant_2)}
  let!(:plot_plant_4) {PlotPlant.create!(plot: plot_2, plant: plant_3)}

  let!(:plot_plant_5) {PlotPlant.create!(plot: plot_3, plant: plant_3)}
  let!(:plot_plant_6) {PlotPlant.create!(plot: plot_3, plant: plant_4)}
  let!(:plot_plant_7) {PlotPlant.create!(plot: plot_3, plant: plant_5)}

  let!(:plot_plant_8) {PlotPlant.create!(plot: plot_4, plant: plant_1)}
  let!(:plot_plant_9) {PlotPlant.create!(plot: plot_4, plant: plant_4)}
  let!(:plot_plant_10) {PlotPlant.create!(plot: plot_4, plant: plant_5)}

  describe "instance methods" do
    it "lists garden's plants w/o duplicates" do
      expect(garden_1.uniq_plants).to eq([plant_1, plant_2, plant_3])
      expect(garden_2.uniq_plants).to eq([plant_1, plant_3, plant_4, plant_5])
    end

    it "lists garden's plants w/harvest <100 days" do
      expect(garden_1.hundred_day_uniq_plants).to eq([plant_2, plant_3])
      expect(garden_2.hundred_day_uniq_plants).to eq([plant_3, plant_5])
    end
  end
end