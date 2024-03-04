require 'rails_helper'

RSpec.describe 'Plots Index Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_tu = Garden.create!(name: "Turing Community Garden", organic: true)

      @plot_east = @garden_tu.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_west = @garden_tu.plots.create!(number: 10, size: "Medium", direction: "West")

      @plant_pepper = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      @plant_cilantro = Plant.create!(name: "Cilantro", description: "Needs lots of water", days_to_harvest: 20)
      @plant_cherry = Plant.create!(name: "Cherry", description: "dry soil better", days_to_harvest: 60)
      @plant_tomatoe = Plant.create!(name: "Red cherry tomatoe", description: "Needs lots of water", days_to_harvest: 5)

      @plot_east.plants << @plant_pepper << @plant_tomatoe
      @plot_west.plants << @plant_cherry << @plant_cilantro
    end

    # User Story 1, Plots Index Page
    it 'displays plot numbers and under each number the name of all that plots plants' do
      # As a visitor, When I visit the plots index page ('/plots')
      visit plots_path
      # I see a list of all plot numbers
      within "#plot-#{@plot_east.id}" do
        expect(page).to have_content("25")
      end
      within "#plot-#{@plot_west.id}" do
        # And under each plot number I see the names of all that plot's plants
        expect(page).to have_content("10")
        expect(page).to have_content("Cilantro")
        expect(page).to have_content("Cherry")
      end
    end
  end
end