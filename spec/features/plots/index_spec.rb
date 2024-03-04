require "rails_helper"

RSpec.describe "Plots Index Page" do
  before do
    summerville = Garden.create!(name: "Summerville", organic: true)
    tomato = Plant.create!(name: "Tomato", description: "Does not like strawberries", days_to_harvest: 20)
    onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10)
    garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 30)
    cherries = Plant.create!(name: "Cherries", description: "Pitless", days_to_harvest: 30)
    eggplant = Plant.create!(name: "Eggplant", description: "Loves strawberries", days_to_harvest: 20)
    watermelon = Plant.create!(name: "Watermelon", description: "Quenches third", days_to_harvest: 10)

    @summer_plot_1 = Plot.create!(number: 1, size: "small", direction: "North", garden_id: summerville.id)

    @summer_plot_2 = Plot.create!(number: 2, size: "medium", direction: "East", garden_id: summerville.id)

    @summer_plot_3 = Plot.create!(number: 3, size: "large", direction: "West", garden_id: summerville.id)

    plot_1_tomato = PlotPlant.create!(plant_id: tomato.id, plot_id: @summer_plot_1.id)
    plot_1_onion = PlotPlant.create!(plant_id: onion.id, plot_id: @summer_plot_1.id)
    plot_1_garlic = PlotPlant.create!(plant_id: garlic.id, plot_id: @summer_plot_1.id)

    plot_2_eggplant = PlotPlant.create!(plant_id: eggplant.id, plot_id: @summer_plot_2.id)
    plot_2_watermelon = PlotPlant.create!(plant_id: watermelon.id, plot_id: @summer_plot_2.id)

    plot_3_garlic = PlotPlant.create!(plant_id: garlic.id, plot_id: @summer_plot_3.id)
    plot_3_cherries = PlotPlant.create!(plant_id: cherries.id, plot_id: @summer_plot_3.id)

    visit "/plots"
  end

  describe "User Story 1" do
    it "has a list of all plot numbers and their plants" do
      save_and_open_page
      expect(page).to have_content("All Plots")

      within "#plots" do
        expect(page).to have_content("Plot Number: 1")
        expect(page).to have_content("Plot Number: 2")
        expect(page).to have_content("Plot Number: 3")
      end

      within "#plot-#{@summer_plot_1.id}" do
        expect(page).to have_content("Tomato, Onion, Garlic")
        expect(page).to have_no_content("Eggplant")
        expect(page).to have_no_content("Watermelon")
        expect(page).to have_no_content("Cherries")
      end

      within "#plot-#{@summer_plot_2.id}" do
        expect(page).to have_content("Eggplant, Watermelon")
        expect(page).to have_no_content("Tomato")
        expect(page).to have_no_content("Onion")
        expect(page).to have_no_content("Garlic")
        expect(page).to have_no_content("Cherries")
      end

      within "#plot-#{@summer_plot_3.id}" do
        expect(page).to have_content("Garlic, Cherries")
        expect(page).to have_no_content("Tomato")
        expect(page).to have_no_content("Onion")
        expect(page).to have_no_content("Eggplant")
        expect(page).to have_no_content("Watermelon")
      end
    end
  end
end
