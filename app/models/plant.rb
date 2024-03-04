class Plant < ApplicationRecord
  has_many :plant_pots
  has_many :pots, through: :plant_pots
end
