class Plant < ApplicationRecord
  has_many :plant_plots
  has_many :plots, through: :plant_plots

  validates_presence_of :name,
                        :description,
                        :days_to_harvest
end
