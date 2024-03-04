require "rails_helper"

RSpec.describe "Gardens show" do
    describe 'User Story 3' do
        it 'shows a unique list of each gardens plants that take less than 100 days to harvest' do
            garden1 = Garden.create!(name: "West Asheville OG", organic: true)
            garden2 = Garden.create!(name: "North Asheville OG", organic: true)
            
            plot1 = garden1.plots.create!(number: 1, size: "Large", direction: "East")
            plot2 = garden1.plots.create!(number: 2, size: "Large", direction: "West")
            plot3 = garden2.plots.create!(number: 3, size: "Large", direction: "North")
            
            avo = plot1.plants.create!(name: "Dwarf avocado", description: "Small and yummy tree", days_to_harvest: 365)
            tomato = plot1.plants.create!(name: "Heirloom Tomato", description: "juicy AF", days_to_harvest: 45)
            spinach = plot2.plants.create!(name: "Spinach", description: "green is good", days_to_harvest: 30)
            arugula = plot2.plants.create!(name: "Arugula", description: "mixed greens are good", days_to_harvest: 28)
            strawberries = plot3.plants.create!(name: "Strawberries", description: "good to have fruit too", days_to_harvest: 33)
            blueberries = plot3.plants.create!(name: "Blueberries", description: "good for the belly", days_to_harvest: 40)
            # User Story 3, Garden's Plants
            # As a visitor
            # When I visit a garden's show page ('/gardens/:id')
            visit garden_path(garden1)
            # Then I see a list of plants that are included in that garden's plots
            # And I see that this list is unique (no duplicate plants)
            # And I see that this list only includes plants that take less than 100 days to harvest
            expect(page).to have_content("Garden Plants")
            expect(page).to have_content("Plant Names:")
            expect(page).to have_content("Heirloom Tomato")
            expect(page).to have_content("Spinach")
            expect(page).to have_content("Arugula")
        end
    end
end