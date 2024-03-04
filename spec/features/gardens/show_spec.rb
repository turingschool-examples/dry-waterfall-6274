require 'rails_helper'

RSpec.describe 'Gardens Show Page', type: :feature do
  describe 'As a Visitor' do
    before(:each) do
      @garden_tu = Garden.create!(name: "Turing Community Garden", organic: true)

      @plot_east = @garden_tu.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_west = @garden_tu.plots.create!(number: 10, size: "Medium", direction: "West")

      @plant_pepper = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      @plant_cilantro = Plant.create!(name: "Cilantro", description: "Needs lots of water", days_to_harvest: 20)
      @plant_cherry = Plant.create!(name: "Cherry", description: "dry soil better", days_to_harvest: 60)
      @plant_tomatoe = Plant.create!(name: "Tomatoe", description: "Needs lots of water", days_to_harvest: 5)
      @plant_orange = Plant.create!(name: "Orange", description: "Light lover", days_to_harvest: 150)

      @plot_east.plants << @plant_pepper << @plant_tomatoe << @plant_orange
      @plot_west.plants << @plant_cherry << @plant_cilantro << @plant_tomatoe
    end

    # User Story 3, Garden's Plants
    it 'displays a unique list of plants that are included in that gardens plots, with the plants that take less than 100 days to harvest' do
      # As a visitor, When I visit a garden's show page ('/gardens/:id')
      visit garden_path(@garden_tu)
      # Then I see a list of plants that are included in that garden's plots
      expect(page).to have_content("Plants in Turing Community Garden")
      # And I see that this list is unique (no duplicate plants)
      expect(page).to have_content("Cilantro")
      expect(page).to have_content("Cherry")
      expect(page).to have_content("Tomatoe")
      # And I see that this list only includes plants that take less than 100 days to harvest
      expect(page).not_to have_content("Orange")
    end

    # Extension 1
    it "displays a list of plants is sorted by the number of times the plant appears in any of that garden's plots from most to least" do
      # As a visitor, When I visit a garden's show page,
      visit garden_path(@garden_tu.id)
      # Then I see the list of plants is sorted by the number of times the plant appears in any of that garden's plots from most to least
      expect("Tomatoe").to appear_before("Cilantro")
      # (Note: you should only make 1 database query to retrieve the sorted list of plants).
    end
  end
end