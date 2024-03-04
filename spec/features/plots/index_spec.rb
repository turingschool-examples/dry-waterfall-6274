require 'rails_helper'

RSpec.describe "Plots Index" do
  before do
    @garden = Garden.create!(name: "Tree Garden", organic: true)

    @plot_1 = @garden.plots.create!(number: 1, size: "Small", direction: "West")
    @plot_2 = @garden.plots.create!(number: 27, size: "Large", direction: "North")
  end

  it "list of all plot numbers" do
    visit plots_path

    expect(page).to have_content("plot number: 1")
    expect(page).to have_content("plot number: 27")
  end
end