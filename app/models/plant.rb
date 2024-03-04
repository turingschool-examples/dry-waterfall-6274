class Plant < ApplicationRecord
  has_many :plot_plants
  has_many :plots, through: :plot_plants

  def self.unique_plants_under_100_days
    Plant.where("days_to_harvest < ?", 100).distinct.order(:created_at)
  end

  def self.most_popular_plants
    Plant.select("plants.*, count(plants.id) as number_of_plants")
          .joins(:plot_plants)
          .group(:id)
          .order("number_of_plants desc, created_at desc")
  end
end
