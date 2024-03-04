require 'rails_helper'

RSpec.describe 'Plot index page' do
  before do
    @garden = Garden.create!(name: "Test Garden")
    @plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: @garden)  
    @plant1 = Plant.create!(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
  
    # @plot1 << @plant1 
  end

  it 'lists all plot numbers' do
    visit "/plots"

    expect(page).to have_content(@plot1.number)
    expect(page).to have_content(@plant1.name)
  end

  context 'it has a button and removes plants' do
    it 'has a button to delete a plant' do
      visit "/plots"

      expect(page).to have_button("Delete Plant")
    end

    it 'can delete a plant and redirect to the index page w/o out the deleted plant' do
      visit "/plots"

      save_and_open_page
      click_on "Delete Plant"

      expect(page).to_not have_content(@plant1.name)
      expect(current_path).to eq("/plots")
    end
  end
end