require 'rails_helper'

RSpec.describe "Plots Index Page", type: :feature do
  let!(:garden) { Garden.create!(name: "Turing Community Garden", organic: true) }
  let!(:plot_1) { garden.plots.create!(number: 1, size: "Large", direction: "East") }
  let!(:plot_2) { garden.plots.create!(number: 2, size: "Small", direction: "West") }

  let!(:plant_1) { Plant.create!(name: "Rose", description: "Flower", days_to_harvest: 20) }
  let!(:plant_2) { Plant.create!(name: "Broccoli", description: "Vegetable", days_to_harvest: 5) }
  let!(:plant_3) { Plant.create!(name: "Lily", description: "Flower/ Bulb", days_to_harvest: 10) }

  let!(:plant_plot_1) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_1.id) }
  let!(:plant_plot_2) { PlantPlot.create!(plot_id: plot_1.id, plant_id: plant_3.id) }
  let!(:plant_plot_3) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_2.id) }
  let!(:plant_plot_4) { PlantPlot.create!(plot_id: plot_2.id, plant_id: plant_3.id) }

  describe "User Story 1" do
    it "has a list of all plots with the names of that plot's plants" do
      visit plots_path

      within "#plot-#{plot_1.id}" do
        expect(page).to have_content(plot_1.number)
        expect(page).to have_content(plant_1.name)
        expect(page).to have_content(plant_3.name)
      end
      within "#plot-#{plot_2.id}" do
        expect(page).to have_content(plot_2.number)
        expect(page).to have_content(plant_2.name)
        expect(page).to have_content(plant_3.name)
      end
    end
  end

  describe "User Story 2" do
    it "has a button to remove each plant from the plot" do
      visit plots_path

      within "#plot-#{plot_1.id}" do
        expect(page).to have_content(plot_1.number)
        expect(page).to have_content(plant_1.name)
        expect(page).to have_content(plant_3.name)
        expect(page).to have_link("Remove", count: 2)
      end
      within "#plot-#{plot_2.id}" do
        expect(page).to have_content(plot_2.number)
        expect(page).to have_content(plant_2.name)
        expect(page).to have_content(plant_3.name)
        expect(page).to have_link("Remove", count: 2)
      end
    end

    it "redirects back to the plots index page, and I no longer see the plant listed" do
      visit plots_path
      within "#plant-#{plant_1.id}" do
        click_on "Remove"
      end

      expect(current_path).to eq(plots_path)
      expect(page).not_to have_content(plant_1.name)

      within "#plot-#{plot_1.id}" do
        expect(page).to have_content(plot_1.number)
        expect(page).to have_content(plant_3.name)
        expect(page).to have_link("Remove", count: 1)
      end
    end
  end
end
