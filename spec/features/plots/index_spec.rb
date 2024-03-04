require "rails_helper"

RSpec.describe "Plots" do
    before :each do
        @garden_1 = Garden.create!(name: "Testgarden", organic: true)
        @garden_2 = Garden.create!(name: "Test2garden", organic: false)

        @plot_1 = Plot.create!(number: 1, size:"small", direction: "east", garden_id: @garden_1.id)
        @plot_2 = Plot.create!(number: 2, size:"meduim", direction: "west", garden_id: @garden_2.id)

        @plant_1 = Plant.create!(name: "flower", description:"prefers desert", days_to_harvest: 120)
        @plant_2 = Plant.create!(name: "grass", description:"prefers water", days_to_harvest: 10)

        @plotplant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
        @plotplant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
        
        
    end
    it "shows a list of all plots with their plants" do
        visit "/plots"
        expect(page).to have_content(@plot_1.number)
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
    end

    it "can remove a plant from a plot" do
        visit "/plots"
        
        expect(page).to have_content(@plot_1.number)
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
        
        first(:button, 'Remove').click

        expect(current_path).to eq("/plots")
        
        expect(page).to_not have_content(@plant_1.name)
    end
    it "can remove a plant for only one plot" do
        @plotplant_3 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_2.id)
        visit "/plots"
        expect(page).to have_content(@plot_1.number)
        expect(page).to have_content(@plot_2.number)
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content(@plant_2.name)
        
        first(:button, 'Remove').click

        expect(current_path).to eq("/plots")
        
        expect(page).to have_content(@plant_1.name)

    end
        
end