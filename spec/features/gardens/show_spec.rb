require 'rails_helper'

RSpec.describe 'Gardens Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_1 = Garden.create!(name: "Jack's Garden", organic: false) 

      @plant_1 = Plant.create!(name: "Rose", description: "Red and thorny", days_to_harvest: 60)
      @plant_2 = Plant.create!(name: "Tulip", description: "Yellow and not thorny", days_to_harvest: 45)
      @plant_3 = Plant.create!(name: "Daisy", description: "White and small", days_to_harvest: 55)
      @plant_4 = Plant.create!(name: "Arugula", description: "Green and leafy", days_to_harvest: 101)

      @plot_1 = @garden_1.plots.create!(number: 1, size: "Large", direction: "South")
      @plot_2 = @garden_1.plots.create!(number: 2, size: "Small", direction: "East")
      @plot_3 = @garden_1.plots.create!(number: 3, size: "Small", direction: "East")
      @plot_4 = @garden_1.plots.create!(number: 4, size: "Small", direction: "East")

      @plot_plant_1 = PlotPlant.create!(plant_id: @plant_1.id, plot_id: @plot_1.id)
      @plot_plant_2 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_1.id)
      @plot_plant_3 = PlotPlant.create!(plant_id: @plant_2.id, plot_id: @plot_2.id)
      @plot_plant_4 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_1.id)
      @plot_plant_5 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_2.id)
      @plot_plant_6 = PlotPlant.create!(plant_id: @plant_3.id, plot_id: @plot_3.id)
      @plot_plant_7 = PlotPlant.create!(plant_id: @plant_4.id, plot_id: @plot_2.id)

      visit garden_path(@garden_1)
    end

    it 'shows a unique list of plants that are in plots within the garden and have a time to harvest that is less than 100 days' do
      expect(page).to have_content(@plant_1.name, count: 1)
      expect(page).to have_content(@plant_2.name, count: 1)
      expect(page).to have_content(@plant_3.name, count: 1)
      expect(page).not_to have_content(@plant_4.name)
    end

    it 'shows plants in order of most to least in terms of how many plots each plant can be found in' do
      expect(@plant_3.name).to appear_before(@plant_2.name)
      expect(@plant_2.name).to appear_before(@plant_1.name)
    end
  end
end