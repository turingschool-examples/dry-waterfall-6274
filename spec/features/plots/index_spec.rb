require 'rails_helper'

RSpec.describe 'plot#index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_1 = Garden.create(name: 'Example Garden', organic: true)
  
      @plant_1 = Plant.create(name: 'Tomato', description: 'Red and juicy', days_to_harvest: 90)
      @plant_2 = Plant.create(name: 'Lettuce', description: 'Green and crisp', days_to_harvest: 30)
      @plant_3 = Plant.create(name: 'Test', description: 'Hello', days_to_harvest: 60)
    
      @plot_1 = Plot.create(number: 1, size: 'Medium', direction: 'North', garden: @garden_1)
      @plot_2 = Plot.create(number: 2, size: 'Large', direction: 'South', garden: @garden_1)
      @plot_3 = Plot.create(number: 3, size: 'Small', direction: 'East', garden: @garden_1)

      @plan_plot_1 = PlantPlot.create(plant: @plant_1, plot: @plot_1)
      @plan_plot_2 =PlantPlot.create(plant: @plant_2, plot: @plot_2)
      @plan_plot_3 =PlantPlot.create(plant: @plant_3, plot: @plot_3)
    end

    # User Story 1, Plots Index Page
    it "plot number and plant name" do
      # As a visitor
      # When I visit the plots index page ('/plots')
      visit plots_path
      # I see a list of all plot numbers
      expect(page).to have_content(@plot_1.number)
      # And under each plot number I see the names of all that plot's plants
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_2.name)
    end

    # User Story 2, Remove a Plant from a Plot
    it "add remove button" do
      # As a visitor
      # When I visit the plots index page
      visit plots_path
      # Next to each plant's name
      # I see a button to remove that plant from that plot
      # When I click on that button
      # I'm returned to the plots index page
      # And I no longer see that plant listed under that plot,
      # And I still see that plant's name under other plots that is was associated with.
      within "#plot-#{@plot_1.id}" do
        expect(page).to have_content(@plant_1.name)
        expect(page).to have_content("Remove")
        first('.remove-button').click
        expect(current_path).to eq(plots_path)
        expect(page).to_not have_content(@plant_2.name)
      end
      within "#plot-#{@plot_2.id}" do
        expect(page).to have_content(@plant_2.name)
        expect(page).to have_content("Remove")
        first('.remove-button').click
        expect(current_path).to eq(plots_path)
        expect(page).to_not have_content(@plant_1.name)
      end
      within "#plot-#{@plot_3.id}" do
        expect(page).to have_content(@plant_3.name)
        expect(page).to have_content("Remove")
        first('.remove-button').click
        expect(current_path).to eq(plots_path)
        expect(page).to_not have_content(@plant_2.name)
      end
    end
  end
end