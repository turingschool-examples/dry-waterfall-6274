require 'rails_helper'

RSpec.describe 'Plots index' do
    describe 'User Story 1' do
        it 'shows all of the plots with their plants' do
                garden1 = Garden.create!(name: "West Asheville OG", organic: true)
                plot1 = garden1.plots.create!(number: 1, size: "Large", direction: "East")
                plot2 = garden1.plots.create!(number: 2, size: "Large", direction: "West")
                plot3 = garden1.plots.create!(number: 3, size: "Medium", direction: "North")
                avo = plot1.plants.create!(name: "Dwarf avocado", description: "Small and yummy tree", days_to_harvest: 365)
                tomato = plot1.plants.create!(name: "Heirloom Tomato", description: "juicy AF", days_to_harvest: 45)
                spinach = plot2.plants.create!(name: "Spinach", description: "green is good", days_to_harvest: 30)
                arugula = plot2.plants.create!(name: "Arugula", description: "mixed greens are good", days_to_harvest: 28)
                strawberries = plot3.plants.create!(name: "Strawberries", description: "good to have fruit too", days_to_harvest: 33)
                blueberries = plot3.plants.create!(name: "Blueberries", description: "good for the belly", days_to_harvest: 40)
        
            # User Story 1, Plots Index Page
            # As a visitor
            # When I visit the plots index page ('/plots')
            visit plots_path
            # I see a list of all plot numbers
            expect(page).to have_content("1")
            expect(page).to have_content("2")
            expect(page).to have_content("3")
            # And under each plot number I see the names of all that plot's plants
            within "#plots-#{plot1.id}" do
                expect(page).to have_content("Plant names:")
                expect(page).to have_content("Dwarf avocado")
                expect(page).to have_content("Heirloom Tomato")
            end
            within "#plots-#{plot2.id}" do
                expect(page).to have_content("Plant names:")
                expect(page).to have_content("Spinach")
                expect(page).to have_content("Arugula")
            end
            within "#plots-#{plot3.id}" do
                expect(page).to have_content("Plant names:")
                expect(page).to have_content("Strawberries")
                expect(page).to have_content("Blueberries")
            end
        end
    end

    describe 'User Story 2' do
            garden1 = Garden.create!(name: "West Asheville OG", organic: true)
            plot1 = garden1.plots.create!(number: 1, size: "Large", direction: "East")
            plot2 = garden1.plots.create!(number: 2, size: "Large", direction: "West")
            avo1 = plot1.plants.create!(name: "Dwarf avocado", description: "Small and yummy tree", days_to_harvest: 365)
            avo2 = plot2.plants.create!(name: "Dwarf avocado", description: "Small and yummy tree", days_to_harvest: 365)
        # User Story 2, Remove a Plant from a Plot
        it 'removes a plant from a plot' do
            # As a visitor
            # When I visit the plots index page
            visit plots_path
            # Next to each plant's name
            # I see a button to remove that plant from that plot
            within "#plots-#{plot1.id}" do
                expect(page).to have_button("Remove plant ID #{avo1.id} from plot #{plot1.number}")
            end
            # When I click on that button
            click_button "Remove plant ID #{avo1.id} from plot #{plot1.number}"
            # I'm returned to the plots index page
            expect(current_path).to eq(plots_path)
            # And I no longer see that plant listed under that plot,
            within "#plots-#{plot1.id}" do
                expect(page).not_to have_content(avo1.name)
            end
            # And I still see that plant's name under other plots that is was associated with.
            within "#plots-#{plot2.id}" do
                expect(page).to have_content(avo2.name)
            end
        end

        # Note: you do not need to test for any sad paths or implement any flash messages. 
    end
end