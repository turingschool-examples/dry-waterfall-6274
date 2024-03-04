require 'rails_helper'

RSpec.describe "Plots Index Page", type: :feature do

    before(:each)  do
        @garden = Garden.create!(name: "Turing Community Garden", organic: true)

        @plot1 = @garden.plots.create!(number: 25, size: "Large", direction: "East")
        @plot2 = @garden.plots.create!(number: 26, size: "Small", direction: "West")

        @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        @plant2 = Plant.create!(name: "Cucumber", description: "Green and refreshing", days_to_harvest: 50)

        @plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
        @plot_plant2 = PlotPlant.create!(plot: @plot2, plant: @plant2)
    end
    
    # User Story 1
   it "visitor sees all plots and their plants" do
        visit "/plots"

        expect(page).to have_content("Plot Number: #{@plot1.number}")
        expect(page).to have_content("Plot Number: #{@plot2.number}")
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
    end
end