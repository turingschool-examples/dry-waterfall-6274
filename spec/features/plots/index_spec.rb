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

    describe 'User story 2' do
        before(:each) do
            @mac_garden = Garden.create!(name: "Mac Garden", organic: true)
            
            @green_plot = Plot.create!(number: 9, size: "Medium", garden_id: @mac_garden.id)
            @blue_plot = Plot.create!(number: 13, size: "Small", garden_id: @mac_garden.id)

            @bell_pepper = Plant.create!(name: "Bell Pepper", description: "Green Bell Pepper", days_to_harvest: 20)
            @dill = Plant.create!(name: "Dill", description: "Dill", days_to_harvest: 10)
            @tomato = Plant.create!(name: "Tomato", description: "Large tomatoes", days_to_harvest: 30)
            @kale = Plant.create!(name: "Kale", description: "Red Kale", days_to_harvest: 15)

            @plant_plot1 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @bell_pepper.id)
            @plant_plot2 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @dill.id)
            @plant_plot3 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @tomato.id)
            @plant_plot4 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @bell_pepper.id)
        end

        it 'removes plant from a plot' do
            # As a visitor
            # When I visit the plots index page
            visit plots_path
            # Next to each plant's name
            # I see a button to remove that plant from that plot
            # When I click on that button
            # I'm returned to the plots index pagewithin("#plot-#{@green_plot.id}") do
            within("#plot-#{@green_plot.id}") do
                expect(page).to have_content("Bell Pepper")
                expect(page).to have_button("Remove Bell Pepper")
                click_on "Remove Bell Pepper"
                expect(current_path).to eq(plots_path)
            end 
            
            visit plots_path

            within("#plot-#{@blue_plot.id}") do
                expect(page).to have_button("Remove Tomato")
                click_on "Remove Tomato"
                expect(current_path).to eq(plots_path)
            end
            # And I no longer see that plant listed under that plot,
            # And I still see that plant's name under other plots that is was associated with.
             visit plots_path

             within("#plot-#{@blue_plot.id}") do
                expect(page).to_not have_button("Remove Tomato")
            end
            
        end
    end
end