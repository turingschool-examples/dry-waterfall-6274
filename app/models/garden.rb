class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def uniq_plants
      self.plants.select("plants.*, count(plants.id) as count")
                  .where("days_to_harvest <= ?", 100)
                  .group(:id)
                  .order("count DESC")
   end
end