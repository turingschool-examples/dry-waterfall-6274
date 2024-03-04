class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plot_plants, dependent: :destroy
  has_many :plants, through: :plot_plants

  def plant_names
    plants.pluck("plants.name")
  end
end