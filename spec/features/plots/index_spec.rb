require "rails_helper"

RSpec.describe "Index Page", type: :feature do
  describe "As a visitor" do

    before do
        @garden_1 = Garden.create!(name: "The best garden", organic: true)
        @garden_2 = Garden.create!(name: "The worst garden", organic: false)

        @plot_1 = @garden_1.plots.create!(number: 10, size: "100 acres", direction: "North")
        @plot_2 = @garden_2.plots.create!(number: 5, size: "1 acre", direction: "South")

        @plant_1 = Plant.create!(name: "Lily's", description: "Bright Yellow", days_to_harvest: 25)
        @plant_2 = Plant.create!(name: "Sun Flower", description: "Barely Alive", days_to_harvest: 40)

        PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
        PlantPlot.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
        PlantPlot.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)
    end

    # User Story 1, Plots Index Page
    it "displays all plot numbers with the name of the plants" do
      # When I visit the plots index page ('/plots')
      visit  plots_path
      # I see a list of all plot numbers
      # And under each plot number I see the names of all that plot's plants
      within "#plot-#{@plot_1.id}" do
        expect(page).to have_content("Plot Number: 10")
        expect(page).to have_content("Plant Name: Lily's")
      end

      within "#plot-#{@plot_2.id}" do
        expect(page).to have_content("Plot Number: 5")
        expect(page).to have_content("Plant Name: Sun Flower")
      end
    end

    # User Story 2, Remove a Plant from a Plot
    it "has a button to remove plants from the plot" do 
      # When I visit the plots index page
      visit plots_path
      # Next to each plant's name
      # I see a button to remove that plant from that plot
      # When I click on that button
      within "#plot-#{@plot_1.id}" do
        expect(page).to have_content("Plant Name: Lily's")
        expect(page).to have_content("Remove Plant")
        click_on("Remove Plant")
      end
      save_and_open_page
      # I'm returned to the plots index page
      expect(current_path).to eq(plots_path)
      # And I no longer see that plant listed under that plot,
      within "#plot-#{@plot_1.id}" do
        expect(page).not_to have_content("Plant Name: Lily's")
      end

      # And I still see that plant's name under other plots that is was associated with.
      within "#plot-#{@plot_2.id}" do
        expect(page).to have_content("Plant Name: Lily's")
      end
    end
  end 
end 