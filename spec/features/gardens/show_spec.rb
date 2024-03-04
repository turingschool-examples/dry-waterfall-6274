require 'rails_helper'

RSpec.describe "Garden Show Page", type: :feature do
  let!(:garden) { Garden.create!(name: "Turing Community Garden", organic: true) }
  let!(:plot_1) { garden.plots.create!(number: 1, size: "Large", direction: "East") }
  let!(:plot_2) { garden.plots.create!(number: 2, size: "Small", direction: "West") }

  let!(:plant_1) { Plant.create!(name: "Rose", description: "Flower", days_to_harvest: 120) }
  let!(:plant_2) { Plant.create!(name: "Broccoli", description: "Vegetable", days_to_harvest: 55) }
  let!(:plant_3) { Plant.create!(name: "Lily", description: "Flower/ Bulb", days_to_harvest: 30) }

  let!(:plant_plot_1) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_1.id) }
  let!(:plant_plot_2) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_3.id) }
  let!(:plant_plot_3) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_2.id) }
  let!(:plant_plot_4) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_3.id) }

  describe "User Story 3" do
    it "has a list of unique plants that take less than 100 days to harvest in the garden's plots" do
      visit garden_path(garden)
      save_and_open_page
      expect(page).to have_content(plant_2.name)
      expect(page).to have_content(plant_3.name)
    end
  end
end
