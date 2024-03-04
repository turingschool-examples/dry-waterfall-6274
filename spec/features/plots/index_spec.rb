require 'rails_helper'

RSpec.describe 'Plots index page' do
    describe 'User story 1' do
        before(:each) do
            @mac_garden = Garden.create!(name: "Mac Garden", organic: true)
            
            @green_plot = Plot.create!(number: 9, size: "Medium", garden_id: @mac_garden.id)
            @blue_plot = Plot.create!(number: 13, size: "Small", garden_id: @mac_garden.id)

            @bell_pepper = Plant.create!(name: "Bell Pepper", description: "Green Bell Pepper", days_to_harvest: 20)
            @dill = Plant.create!(name: "Dill", description: "Dill", days_to_harvest: 10)
            @tomato = Plant.create!(name: "Tomato", description: "Large tomatoes", days_to_harvest: 30)
            @kale = Plant.create!(name: "Kale", description: "Red Kale", days_to_harvest: 15)

            @green_plot.plants << [@bell_pepper, @dill]
            @blue_plot.plants << [@tomato, @kale]
        end
        it 'shows a list of plot numbers and the plot plants' do
            # As a visitor
            # When I visit the plots index page ('/plots')
            visit plots_path
            # I see a list of all plot numbers
            # And under each plot number I see the names of all that plot's plants
            within("#plot-#{@green_plot.id}") do
                expect(page).to have_content("Plot number: 9")
                expect(page).to have_content("Bell Pepper")
                expect(page).to have_content("Dill")
            end
            
            within("#plot-#{@blue_plot.id}") do
                expect(page).to have_content("Plot number: 13")
                expect(page).to have_content("Tomato")
                expect(page).to have_content("Kale")
            end
        end
    end
end