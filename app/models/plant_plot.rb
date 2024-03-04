class PlantPlot < ApplicationRecord
  belongs_to :plant
  belongs_to :plot

  validates_presence_of :plant_id,
                        :plot_id
end
