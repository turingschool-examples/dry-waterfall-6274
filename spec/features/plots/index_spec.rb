require 'rails_helper'

RSpec.describe 'Plot index page' do
  before do
    @garden = Garden.create!(name: "Test Garden")
    @plot1 = Plot.create!(number: 1, size: "Small", direction: "North", garden: @garden)  
    @plant1 = Plant.create!(name: "Sunflower", description: "A flower of the sun", days_to_harvest: 50)
  end

  it 'lists all plot numbers' do
    visit "/plots"

    expect(page).to have_content(@plot1.number)
  end
end