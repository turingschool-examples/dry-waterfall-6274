require "rails_helper"

RSpec.describe "Gardens show page" do
  before(:each) do
    
    @garden = Garden.create(name: "Example Garden", organic: true)

    # Create plots associated with the garden
    @plot1 = Plot.create(number: 1, size: "Medium", direction: "North", garden: @garden)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "East", garden: @garden)

    # Create plants with different harvest times
    @plant1 = Plant.create(name: "Tomato Plant", description: "Red fruit", days_to_harvest: 60) #will appear 
    @plant2 = Plant.create(name: "Lettuce Plant", description: "Leafy green", days_to_harvest: 30) #will apear 
    @plant3 = Plant.create(name: "Carrot plant", description: "Root vegetable", days_to_harvest: 120) #will not appear 
    @plant4 = Plant.create(name: "Cucumber Plant", description: "Green vegetable", days_to_harvest: 99) #will appear 
    # plant5 = Plant.create(name: "Chili", description: "Green vegetable", days_to_harvest: 40)
    # plant6 = Plant.create(name: "Grape", description: "Green vegetable", days_to_harvest: 134)

    # Associate plants with plots using PlotPlant
    PlotPlant.create(plot: @plot1, plant: @plant1)
    PlotPlant.create(plot: @plot1, plant: @plant2)
    PlotPlant.create(plot: @plot1, plant: @plant3)
    PlotPlant.create(plot: @plot1, plant: @plant4)

    PlotPlant.create(plot: @plot2, plant: @plant3)
    PlotPlant.create(plot: @plot2, plant: @plant4)
    PlotPlant.create(plot: @plot2, plant: @plant1)
    PlotPlant.create(plot: @plot2, plant: @plant2)
  end

  describe 'US 3' do
    it ' has list of plants that are included in that gardens plots' do
     

      visit garden_path(@garden)
      # When I visit a garden's show page ('/gardens/:id')
      expect(page).to have_content('Plants in Garden plot that take less than 100 days to harvest:')

      expect(page).to have_content("Tomato Plant")

      expect(page).to have_content("Lettuce Plant")

      expect(page).to have_content("Cucumber Plant")

      expect(page).to_not have_content("Carrot plant")
      # save_and_open_page
      # Then I see a list of plants that are included in that garden's plots
      # And I see that this list is unique (no duplicate plants)
      # And I see that this list only includes plants that take less than 100 days to harvest


     
    end
  end
end