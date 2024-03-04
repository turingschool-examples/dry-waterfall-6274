require "rails_helper"

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  it "#one_hundred_or_less_harvest_days" do
    let!(:garden) { create(:garden) }
    let!(:plot1) { create(:plot, garden: garden) }
    let!(:plot2) { create(:plot, garden: garden) }
    let!(:plant1) { create(:plant, plot: plot1, days_to_harvest: 30) }
    let!(:plant2) { create(:plant, plot: plot2, days_to_harvest: 120) }
    let!(:plant3) { create(:plant, plot: plot2, days_to_harvest: 80) }

    expect(garden.one_hundred_or_less_harvest_days.count).to eq(2)
  end
end