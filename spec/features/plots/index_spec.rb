require 'rails_helper'

RSpec.describe 'Plots Index Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @garden_tu = Garden.create!(name: "Turing Community Garden", organic: true)

      @plot_east = @garden_tu.plots.create!(number: 25, size: "Large", direction: "East")
      @plot_west = @garden_tu.plots.create!(number: 10, size: "Medium", direction: "West")

      @plant_pepper = Plant.create!(name: "Purple Beauty Sweet Bell Pepper", description: "Prefers rich, well draining soil.", days_to_harvest: 90)
      @plant_cilantro = Plant.create!(name: "Cilantro", description: "Needs lots of water", days_to_harvest: 20)
      @plant_cherry = Plant.create!(name: "Cherry", description: "dry soil better", days_to_harvest: 60)
      @plant_tomatoe = Plant.create!(name: "Tomatoe", description: "Needs lots of water", days_to_harvest: 5)

      @plot_east.plants << @plant_pepper << @plant_tomatoe
      @plot_west.plants << @plant_cherry << @plant_cilantro << @plant_tomatoe
    end

    # User Story 1, Plots Index Page
    it 'displays plot numbers and under each number the name of all that plots plants' do
      # As a visitor, When I visit the plots index page ('/plots')
      visit plots_path
      # I see a list of all plot numbers
      within ".plot-#{@plot_east.id}" do
        expect(page).to have_content("25")
      end
      within ".plot-#{@plot_west.id}" do
        # And under each plot number I see the names of all that plot's plants
        expect(page).to have_content("10")
        expect(page).to have_content("Cilantro")
        expect(page).to have_content("Cherry")
      end
    end

    # User Story 2, Remove a Plant from a Plot
    it "allows to remove a plant from a plot" do
      # As a visitor When I visit the plots index page
      visit plots_path
      # Next to each plant's name
      within ".plot-#{@plot_east.id}" do
        within "#plant-#{@plant_pepper.id}" do
          # I see a button to remove that plant from that plot
          expect(page).to have_button("Remove")
        end
        within "#plant-#{@plant_tomatoe.id}" do
          # When I click on that button
          click_button("Remove")
          # I'm returned to the plots index page
          expect(current_path).to eq(plots_path)
        end
        # And I no longer see that plant listed under that plot,
        expect(page).not_to have_content("Tomatoe")
      end
      
      within ".plot-#{@plot_west.id}" do
        # And I still see that plant's name under other plots that is was associated with.
        within "#plant-#{@plant_tomatoe.id}" do
          expect(page).to have_content("Tomatoe")
        end
      end
      # Note: you do not need to test for any sad paths or implement any flash messages. 
    end
  end
end