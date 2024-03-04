require 'rails_helper'

RSpec.describe "Plots Index" do
  before do
    @garden = Garden.create!(name: "Tree Garden", organic: true)

    @plot_1 = @garden.plots.create!(number: 1, size: "Small", direction: "West")
    @plot_2 = @garden.plots.create!(number: 27, size: "Large", direction: "North")

    @plant_1 = @plot_1.plants.create!(name: "Rose", description: "Red with green stem", days_to_harvest: 3)
    @plant_2 = @plot_1.plants.create!(name: "Banna Tree", description: "Bannas grow here", days_to_harvest: 3)
    @plant_3 = @plot_2.plants.create!(name: "Violet Star", description: "Purple star like flower", days_to_harvest: 3)
    @plant_4 = @plot_2.plants.create!(name: "Sunflower", description: "Yellow and round", days_to_harvest: 3)
  end

  describe "User Story 1" do
    it "list of all plot numbers" do
      visit plots_path

      expect(page).to have_content("plot number: 1")
      expect(page).to have_content("plot number: 27")
    end

    it "under each plot number I see the names of all that plot's plants" do
      visit plots_path

      expect(page).to have_content("Rose")
      expect(page).to have_content("Banna Tree")
      expect(page).to have_content("Violet Star")
      expect(page).to have_content("Sunflower")
    end
  end

  describe "User Story 2" do
    it "has a button to remove that plant from that plot" do
      visit plots_path

      @plot_1.plants.each do |plant|
        within "#plants-#{plant.id}" do
          expect(page).to have_content("Rose")
          expect(page).to have_button("Remove")

          click_on "Remove"

          expect(current_path).to eq(plots_path)
          expect(page).to_not have_content("Rose")
        end
      end
    end

  end
end