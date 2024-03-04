require "rails_helper"

RSpec.describe "Plots Index Page" do
  before(:each) do
    @garden1 = Garden.create(name: "Turing Community Garden", organic: true)
    @garden2 = Garden.create(name: "Example Garden", organic: false)
    
    # Create some plots and associate them with gardens
    @plot1 = Plot.create(number: 1, size: "Medium", direction: "North", garden: @garden1)
    @plot2 = Plot.create(number: 2, size: "Large", direction: "East", garden: @garden1)
    
    # Create some plants
    @plant1 = Plant.create(name: "Tomato", description: "Red fruit", days_to_harvest: 60)
    @plant2 = Plant.create(name: "Lettuce", description: "Leafy green", days_to_harvest: 200)
    @plant3 = Plant.create(name: "Carrot", description: "Root vegetable", days_to_harvest: 101)
    @plant4 = Plant.create(name: "Carrot", description: "Root vegetable", days_to_harvest: 10)
    
    # Associate plants with plots using PlotPlant
    PlotPlant.create(plot: @plot1, plant: @plant1)
    PlotPlant.create(plot: @plot1, plant: @plant2)
    PlotPlant.create(plot: @plot2, plant: @plant2)
    PlotPlant.create(plot: @plot2, plant: @plant3)

  end
  #plot 1 has plant 1 and plant 2 
  #plot 2 has plant 2 and plant 3

  describe 'US 1' do
    it 'has list of all plot numbers And under each plot number I see the names of all that plots plants' do

      visit plots_path
      # When I visit the plots index page ('/plots')

   
      expect(page).to have_content('Plot Number: 1')
      # I see a list of all plot numbers

      within ("#plot-#{@plot1.id}") do 
        expect(page).to have_content('Tomato Plant')
        expect(page).to have_content('Lettuce Plant')
        expect(page).to_not have_content('Carrot Plant')
      end

      expect(page).to have_content('Plot Number: 2')

      within ("#plot-#{@plot2.id}") do 
        expect(page).to have_content('Lettuce Plant')
        expect(page).to have_content('Carrot Plant')
        expect(page).to_not have_content('Tomato Plant')
      end
      # And under each plot number I see the names of all that plot's plants
      # save_and_open_page
    end
  end

  describe 'US 2 ' do
    it 'Removes a plant from a plot' do
      visit plots_path
      # When I visit the plots index page

      within ("#plot-#{@plot1.id}") do 
        expect(page).to have_content('Tomato Plant')
        expect(page).to have_button('Remove Tomato')
        # Next to each plant's name

        expect(page).to have_content('Lettuce Plant')
        expect(page).to have_button('Remove Lettuce')
        # I see a button to remove that plant from that plot

        click_button("Remove Lettuce")
      end

      # When I click on that button

      expect(current_path).to eq(plots_path)
      # I'm returned to the plots index page

      within ("#plot-#{@plot1.id}") do 
        expect(page).to have_content('Tomato Plant')
        expect(page).to have_button('Remove Tomato')

        expect(page).to_not have_content('Lettuce Plant')
        expect(page).to_not have_button('Remove Lettuce')
        # And I no longer see that plant listed under that plot,

      end
     

      within ("#plot-#{@plot2.id}") do 
        expect(page).to have_content('Lettuce Plant')
        expect(page).to have_button('Remove Lettuce')

        # And I still see that plant's name under other plots that is was associated with.
        expect(page).to have_content('Carrot Plant')
        expect(page).to have_button('Remove Carrot')

      end
      
      
      # Note: you do not need to test for any sad paths or implement any flash messages. 
      
    end
  end
end