require "rails_helper"

RSpec.describe "Show Page", type: :feature do
  describe "As a visitor" do

    before do
      @garden_1 = Garden.create!(name: "The best garden", organic: true)
      @garden_2 = Garden.create!(name: "The worst garden", organic: false)

      @plot_1 = @garden_1.plots.create!(number: 10, size: "100 acres", direction: "North")
      @plot_2 = @garden_2.plots.create!(number: 5, size: "1 acre", direction: "South")

      @plant_1 = Plant.create!(name: "Lily's", description: "Bright Yellow", days_to_harvest: 25)
      @plant_4 = Plant.create!(name: "Don't see me", description: "Bright Yellow", days_to_harvest: 102)
      @plant_2 = Plant.create!(name: "Sun Flower", description: "Barely Alive", days_to_harvest: 40)

      PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
      PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
      PlantPlot.create!(plant_id: @plant_4.id, plot_id: @plot_1.id)
      PlantPlot.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
      PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)
    end

    # User Story 3, Garden's Plants
    it "displays all plants in that gardens plot" do
      # When I visit a garden's show page ('/gardens/:id')
      visit garden_path(@garden_1.id)
      # Then I see a list of plants that are included in that garden's plots
      expect(page).to have_content(@plant_1.name)
      # And I see that this list is unique (no duplicate plants)
      expect(@garden_1.harvestable_plants.count).to eq(1)
      # And I see that this list only includes plants that take less than 100 days to harvest
      expect(page).not_to have_content(@plant_4.name)
    end
  end 
end