class Plant < ApplicationRecord
    has_many :plot_plants
    has_many :plots, through: :plot_plants

    def self.harvest_under_100_days
        joins(plot_plants: :plot)
        .where("plants.days_to_harvest < ?", 100)
        .distinct
    end
end