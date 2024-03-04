require "rails_helper"

RSpec.describe Plot, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plot_plants) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  before do
    summerville = Garden.create!(name: "Summerville", organic: true)
    tomato = Plant.create!(name: "Tomato", description: "Does not like strawberries", days_to_harvest: 20)
    onion = Plant.create!(name: "Onion", description: "Loves to make people cry", days_to_harvest: 10)
    garlic = Plant.create!(name: "Garlic", description: "Wards off vampires", days_to_harvest: 30)

    @summer_plot_1 = Plot.create!(number: 1, size: "small", direction: "North", garden_id: summerville.id)

    plot_1_tomato = PlotPlant.create!(plant_id: tomato.id, plot_id: @summer_plot_1.id)
    plot_1_onion = PlotPlant.create!(plant_id: onion.id, plot_id: @summer_plot_1.id)
    plot_1_garlic = PlotPlant.create!(plant_id: garlic.id, plot_id: @summer_plot_1.id)
  end

  describe "instance methods" do
    describe "#name_of_plants" do
      it "displays the names of all of a plots plants" do
        expect(@summer_plot_1.name_of_plants).to eq(["Tomato", "Onion", "Garlic"])
      end
    end
  end
end
