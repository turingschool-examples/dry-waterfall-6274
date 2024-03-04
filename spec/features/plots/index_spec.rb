require 'rails_helper'

RSpec.describe 'Plots Index Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_1 = Garden.create!(name: "Jack's Garden", organic: false) 

      @plant_1 = Plant.create!(name: "Rose", description: "Red and thorny", days_to_harvest: 60)
      @plant_2 = Plant.create!(name: "Tulip", description: "Yellow and not thorny", days_to_harvest: 45)
      @plant_3 = Plant.create!(name: "Daisy", description: "White and small", days_to_harvest: 55)

      @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "South")
      @plot_2 = @garden_1.plots.create!(number: 2, size: "Small", direction: "East")

      @plot_plant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
      @plot_plant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
      @plot_plant_3 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
      @plot_plant_4 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_2.id)    
    end

    it 'can see a list of all plot numbers and a list of every plant inside each plot' do
      visit plots_path

      within "#plot_#{@plot_1.id}" do
        expect(page).to have_content("Plot ##{@plot_1.id}")
        expect(page).to have_content("Plants: #{@plant_1.name}, #{@plant_2.name}")
      end
      
      within "#plot_#{@plot_2.id}" do
        expect(page).to have_content("Plot ##{@plot_2.id}")
        expect(page).to have_content("Plants: #{@plant_2.name}, #{@plant_3.name}")
      end
    end
  end
end