require 'rails_helper'

RSpec.describe 'plot index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden = Garden.create!(name: "Larry's Garden", organic: true)

      @plot_1 = @garden.plots.create(number: 1, size: "large", direction: "west")
      @plot_2 = @garden.plots.create(number: 2, size: "small", direction: "east")

      @plant_1 = Plant.create!(name: "Rose", description: "red", days_to_harvest: 5)

      PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
    end

    # User Story 1, Plots Index Page
    it 'displays plot name and associated plants' do
      # When I visit the plots index page ('/plots')
      visit "/plots"

      within '.plots' do
        within "#plot-#{@plot_1.id}" do   
          # I see a list of all plot numbers
          expect(page).to have_content(@plot_1.number)
          # And under each plot number I see the names of all that plot's plants
          expect(page).to have_content(@plant_1.name)
        end

        within "#plot-#{@plot_2.id}" do  
          expect(page).to have_content(@plot_2.number)
          expect(page).to_not have_content(@plant_1.name)
        end
      end
    end
  end
end