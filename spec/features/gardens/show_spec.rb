require "rails_helper"

RSpec.describe "Garden Show Page" do
  before do
    summerville = Garden.create!(name: "Summerville", organic: true)
    tomato = Plant.create!(name: "Tomato", description: "Does not like strawberries", days_to_harvest: 100)
    onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10)
    garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 300)
    cherries = Plant.create!(name: "Cherries", description: "Pitless", days_to_harvest: 30)
    eggplant = Plant.create!(name: "Eggplant", description: "Loves strawberries", days_to_harvest: 20)
    watermelon = Plant.create!(name: "Watermelon", description: "Quenches third", days_to_harvest: 10)

    summer_plot_1 = Plot.create!(number: 1, size: "small", direction: "North", garden_id: summerville.id)
    summer_plot_2 = Plot.create!(number: 2, size: "medium", direction: "East", garden_id: summerville.id)
    summer_plot_3 = Plot.create!(number: 3, size: "large", direction: "West", garden_id: summerville.id)

    plot_1_tomato = PlotPlant.create!(plant_id: tomato.id, plot_id: summer_plot_1.id)
    plot_1_onion = PlotPlant.create!(plant_id: onion.id, plot_id: summer_plot_1.id)
    plot_1_garlic = PlotPlant.create!(plant_id: garlic.id, plot_id: summer_plot_1.id)
    plot_1_cherries = PlotPlant.create!(plant_id: cherries.id, plot_id: summer_plot_1.id)


    plot_2_eggplant = PlotPlant.create!(plant_id: eggplant.id, plot_id: summer_plot_2.id)
    plot_2_watermelon = PlotPlant.create!(plant_id: watermelon.id, plot_id: summer_plot_2.id)
    plot_2_cherries = PlotPlant.create!(plant_id: cherries.id, plot_id: summer_plot_2.id)

    plot_3_garlic = PlotPlant.create!(plant_id: garlic.id, plot_id: summer_plot_3.id)
    plot_3_cherries = PlotPlant.create!(plant_id: cherries.id, plot_id: summer_plot_3.id)
    plot_3_eggplant = PlotPlant.create!(plant_id: eggplant.id, plot_id: summer_plot_2.id)


    visit "/gardens/#{summerville.id}"
  end

  describe "User Story 3 - Garden's Plants" do
    it "has a unique list of plants under 100 days to harvest that are included in that garden's plots" do
      expect(page).to have_text("Summerville's Plants")
      expect(page).to have_text("Plants that take under 100 days to harvest")
      within "#unique-plants-under-100" do
        expect(page).to have_css("li", count: 4)
        expect(page).to have_text("Onion")
        expect(page).to have_text("Cherries")
        expect(page).to have_text("Eggplant")
        expect(page).to have_text("Watermelon")
        expect(page).to have_no_text("Tomato")
        expect(page).to have_no_text("Garlic")
      end
    end
  end

  describe "Extension 1" do
    it "has a list of Plants sorted by number of times the Plant appears in the Garden's Plots desc" do
      expect(page).to have_text("Plants that appear most often:")
      save_and_open_page
      within "#plants-most-often" do
        plants = page.all("li")

        expect(plants[0]).to have_text("Cherries")
        expect(plants[1]).to have_text("Garlic")
        expect(plants[2]).to have_text("Eggplant")
        expect(plants[3]).to have_text("Tomato")
        expect(plants[4]).to have_text("Onion")
        expect(plants[5]).to have_text("Watermelon")
      end
    end
  end
end
