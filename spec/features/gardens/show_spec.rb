require 'rails_helper'

RSpec.describe '', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_1 = Garden.create(name: 'Example Garden', organic: true)
  
      @plant_1 = Plant.create(name: 'Tomato', description: 'Red and juicy', days_to_harvest: 100)
      @plant_2 = Plant.create(name: 'Lettuce', description: 'Green and crisp', days_to_harvest: 30)
  
      @plot_1 = Plot.create(number: 1, size: 'Medium', direction: 'North', garden: @garden_1)
  
      @plan_plot_1 = PlantPlot.create(plant: @plant_1, plot: @plot_1)
      @plan_plot_2 =PlantPlot.create(plant: @plant_2, plot: @plot_1)
    end

    # User Story 3, Garden's Plants
    it "displays a unique list of " do
      # As a visitor
      # When I visit a garden's show page ('/gardens/:id')
      visit garden_path(@garden_1)
      # Then I see a list of plants that are included in that garden's plots
      # And I see that this list is unique (no duplicate plants)
      # And I see that this list only includes plants that take less than 100 days to harvest
      expect(page).to have_content(@plant_2.name)
      expect(page).to_not have_content(@plant_1.name)
    end
  end
end