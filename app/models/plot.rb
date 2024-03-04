class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plant_plots, dependent: :destroy
   has_many :plants, through: :plant_plots
end