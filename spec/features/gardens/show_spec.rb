require "rails_helper"

RSpec.describe "Garden Show Page", type: :feature do
   describe "as a visitor" do
      before(:each) do
         @garden1 = Garden.create!(name: "Majorelle Garden", organic: false)

         @plot1 = Plot.create!(number: 13, size: "Small", direction: "West", garden_id: @garden1.id)
         @plot2 = Plot.create!(number: 23, size: "Medium", direction: "East", garden_id: @garden1.id)
         @plot3 = Plot.create!(number: 36, size: "Large", direction: "North", garden_id: @garden1.id)

         @plant1 = Plant.create!(name: "Rose", description: "Delicate Flower", days_to_harvest: 50)
         @plant2 = Plant.create!(name: "Basil", description: "Fragrant Herb", days_to_harvest: 75)
         @plant3 = Plant.create!(name: "Strawberries", description: "Juicy Fruit", days_to_harvest: 65)
         @plant4 = Plant.create!(name: "Zucchini", description: "Summer Squash", days_to_harvest: 60)
         @plant5 = Plant.create!(name: "Sunflower", description: "Tall bright yellow flower", days_to_harvest: 105)
         @plant6 = Plant.create!(name: "Lavender", description: "Perenial Herb", days_to_harvest: 120)
         @plant7 = Plant.create!(name: "Daisies", description: "Cheerful Flower", days_to_harvest: 70)

         @plot_plant1 = PlotPlant.create!(plot: @plot1, plant: @plant5) #1
         @plot_plant2 = PlotPlant.create!(plot: @plot1, plant: @plant4) ##2
         @plot_plant3 = PlotPlant.create!(plot: @plot2, plant: @plant5) #1
         @plot_plant4 = PlotPlant.create!(plot: @plot2, plant: @plant1) #####5
         @plot_plant5 = PlotPlant.create!(plot: @plot3, plant: @plant3) ###3
         @plot_plant6 = PlotPlant.create!(plot: @plot3, plant: @plant4) ##2
         @plot_plant7 = PlotPlant.create!(plot: @plot3, plant: @plant2) ####4
         @plot_plant8 = PlotPlant.create!(plot: @plot3, plant: @plant5) #1
         @plot_plant9 = PlotPlant.create!(plot: @plot3, plant: @plant4) ##2
         @plot_plant10 = PlotPlant.create!(plot: @plot3, plant: @plant3) ###3
         @plot_plant11 = PlotPlant.create!(plot: @plot3, plant: @plant5) #1
      end

      it 'see a list of plants that are included in the gardens plots' do
         visit garden_path(@garden1)

         expect(page).to have_content(@garden1.name)
         expect(page).to have_content(@plant1.name)
         expect(page).to have_content(@plant2.name)
         expect(page).to have_content(@plant3.name)
         expect(page).to have_content(@plant4.name)
         expect(page).to have_no_content(@plant5.name)
         expect(page).to have_no_content(@plant6.name)
         expect(page).to have_no_content(@plant7.name)
      end

      it 'see a list of plants that are included in the gardens plots sorted by the number of times the plant appears' do
         visit garden_path(@garden1)

         expect(@plant4.name).to appear_before(@plant3.name)
         expect(@plant3.name).to appear_before(@plant1.name)
         expect(@plant1.name).to appear_before(@plant2.name)
      end
   end
end