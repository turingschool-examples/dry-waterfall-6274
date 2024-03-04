class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plant_plots
   has_many :plants, through: :plant_plots

   validates_presence_of :number,
                         :size,
                         :direction
end
