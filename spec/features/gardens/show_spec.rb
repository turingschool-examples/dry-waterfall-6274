require 'rails_helper'

RSpec.describe 'garden show', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden = Garden.create!(name: "Larry's Garden", organic: true)

      @plot_1 = @garden.plots.create(number: 1, size: "large", direction: "west")
      @plot_2 = @garden.plots.create(number: 2, size: "small", direction: "east")

      @plant_1 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 5)
      @plant_2 = Plant.create!(name: "Sunflower", description: "red", days_to_harvest: 115)

      PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
      PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_2.id)
      PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
    end

    # User Story 3, Garden's Plants
    it 'displays an unique list of plants to be harvested in less then 100 days' do
      # When I visit a garden's show page ('/gardens/:id')
      visit "/gardens/#{@garden.id}"
      # Then I see a list of plants that are included in that garden's plots
      within '.plants-under-100' do
        # And I see that this list is unique (no duplicate plants)
        expect(page).to have_content(@plant_1.name, count: 1)
        # And I see that this list only includes plants that take less than 100 days to harvest
        expect(page).to have_content(@plant_1.name)
        expect(page).to_not have_content(@plant_2.name)
      end
    end
  end
end