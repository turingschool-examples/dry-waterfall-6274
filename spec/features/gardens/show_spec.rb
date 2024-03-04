require 'rails_helper'

RSpec.describe 'Garden Show page' do
  let!(:garden) { create(:garden) }
  let!(:plot1) { create(:plot, garden: garden) }
  let!(:plot2) { create(:plot, garden: garden) }
  let!(:plant1) { create(:plant, plot: plot1, days_to_harvest: 30) }
  let!(:plant2) { create(:plant, plot: plot2, days_to_harvest: 120) }
  let!(:plant3) { create(:plant, plot: plot2, days_to_harvest: 80) }

  it 'has a unique list of plants in the garden plots' do
    visit "/gardens/#{garden.id}"
  end

  it 'has plants that only have less than 100 days to harvest' do
    visit "/gardens/#{garden.id}"

    expect(page).to_not have_content(plant2.id)
    expect(page).to have_content(plant3.id)
    expect(page).to have_content(plant1.id)
  end
end