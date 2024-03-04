require 'rails_helper'

RSpec.describe 'Plot index page' do
  it 'lists all plot numbers' do
    garden1 = Garden.create(name: "My Garden", organic: true)
    plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
    plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
    
    plot1.plants << plant1

    visit "/plots"

    expect(page).to have_content(plot1.number)
    expect(page).to have_content(plant1.name)
  end

  context 'it has a button and removes plants' do
    it 'has a button to delete a plant' do
      garden1 = Garden.create(name: "My Garden", organic: true)
      plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
      plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
      
      plot1.plants << plant1

      visit "/plots"

      expect(page).to have_button("Delete Plant")
    end

    it 'can delete a plant and redirect to the index page w/o out the deleted plant' do
      garden1 = Garden.create(name: "My Garden", organic: true)
      plot1 = Plot.create(number: 1, size: "Small", direction: "North", garden: garden1)
      plant1 = Plant.create(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
      
      plot1.plants << plant1
      
      visit "/plots"

      save_and_open_page
      click_on "Delete Plant"

      expect(page).to_not have_content(plant1.name)
      expect(current_path).to eq("/plots")
    end
  end
end