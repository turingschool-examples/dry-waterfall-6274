require "rails_helper"

RSpec.describe "Garden Show", type: :feature do
  describe "As a visitor" do
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

    before do
      visit "/gardens/#{garden_1.id}"
    end

    it "displays all garden's plants once that have <100 days_to_harvest" do
      expect(page).to have_content("Potato")
      expect(page).to have_content("Cabbage")
      expect(page).to_not have_content("Pumpkin")

      visit "/gardens/#{garden_2.id}"
      expect(page).to have_content("Cabbage")
      expect(page).to have_content("Tomato")
      expect(page).to_not have_content("Pumpkin")
      expect(page).to_not have_content("Carrot")
    end
  end
end