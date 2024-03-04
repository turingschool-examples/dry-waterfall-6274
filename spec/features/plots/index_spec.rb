require "rails_helper"

RSpec.describe "Plots Index Page" do
  before do
    summerville = Garden.create!(name: "Summerville", organic: true)
    @summer_plot_1 = Plot.create!(number: 1, size: "small", direction: "North", garden_id: summerville.id)
    plot_1_tomato = Plant.create!(name: "Tomato", description: "Does not like strawberries", days_to_harvest: 20, plot_id: summer_plot_1.id)
    plot_1_onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10, plot_id: summer_plot_1.id)
    plot_1_garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 30, plot_id: summer_plot_1.id)

    @summer_plot_2 = Plot.create!(number: 2, size: "medium", direction: "East", garden_id: summerville.id)
    plot_2_eggplant = Plant.create!(name: "Eggplant", description: "Loves strawberries", days_to_harvest: 20, plot_id: summer_plot_2.id)
    plot_2_watermelon = Plant.create!(name: "Watermelon", description: "Quenches third", days_to_harvest: 10, plot_id: summer_plot_2.id)

    @summer_plot_3 = Plot.create!(number: 3, size: "large", direction: "West", garden_id: summerville.id)
    plot_3_garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 30, plot_id: summer_plot_3.id)
    plot_3_garlic = Plant.create!(name: "Cherries", description: "Pitless", days_to_harvest: 30, plot_id: summer_plot_3.id)

    visit "/plots"
  end

  describe "User Story 1" do
    it "has a list of all plot numbers and their plants" do
      expect(page).to have_content("All Plots")
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
