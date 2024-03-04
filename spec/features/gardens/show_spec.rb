require 'rails_helper'

RSpec.describe 'Garden show page' do
    describe 'User story 3' do
        before(:each) do
            @mac_garden = Garden.create!(name: "Mac Garden", organic: true)
            
            @green_plot = Plot.create!(number: 9, size: "Medium", garden_id: @mac_garden.id)
            @blue_plot = Plot.create!(number: 13, size: "Small", garden_id: @mac_garden.id)

            @bell_pepper = Plant.create!(name: "Bell Pepper", description: "Green Bell Pepper", days_to_harvest: 100)
            @dill = Plant.create!(name: "Dill", description: "Dill", days_to_harvest: 10)
            @tomato = Plant.create!(name: "Tomato", description: "Large tomatoes", days_to_harvest: 30)
            @kale = Plant.create!(name: "Kale", description: "Red Kale", days_to_harvest: 101)

            @plant_plot1 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @bell_pepper.id)
            @plant_plot2 = PlantPlot.create!(plot_id: @green_plot.id, plant_id: @dill.id)
            @plant_plot3 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @tomato.id)
            @plant_plot4 = PlantPlot.create!(plot_id: @blue_plot.id, plant_id: @bell_pepper.id)
        end

        it 'display a unique list of plants that take less than 100 days to harvest' do
            # As a visitor
            # When I visit a garden's show page ('/gardens/:id')
            visit garden_path(@mac_garden)
            # Then I see a list of plants that are included in that garden's plots
            # And I see that this list is unique (no duplicate plants)
            # And I see that this list only includes plants that take less than 100 days to harvest
            expect(page).to have_content("Dill")
            expect(page).to have_content("Tomato")
            expect(page).to_not have_content("Bell Pepper")
            expect(page).to_not have_content("Kale")
        end
    end
end