class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plot_plants, dependent: :destroy
end