require 'rails_helper'

RSpec.describe "Gardens Show Page", type: :feature do

    before(:each)  do
        @garden = Garden.create!(name: "Turing Community Garden", organic: true)

        @plot1 = @garden.plots.create!(number: 25, size: "Large", direction: "East")
        @plot2 = @garden.plots.create!(number: 26, size: "Small", direction: "West")

        @plant1 = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
        @plant2 = Plant.create!(name: "Cucumber", description: "Green and refreshing", days_to_harvest: 50)
        @plant3 = Plant.create!(name: "Tomato", description: "Red and juicy", days_to_harvest: 110)

        @plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant1)
        @plot_plant2 = PlotPlant.create!(plot: @plot2, plant: @plant2)
    end

    it "shows a list of unique plants in the garden with harvest days under 100" do
        visit "/gardens/#{@garden.id}"
    
        
        expect(page).to have_content("Plants in the Garden that take less than 100 days to harvest")
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
        expect(page).not_to have_content(@plant3.name)
    end
end