class Plant < ApplicationRecord
  has_many :plot_plants, dependent: :destroy
  has_many :plots, through: :plot_plants
  has_many :gardens, through: :plots
end
