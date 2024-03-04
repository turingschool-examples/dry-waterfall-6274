class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def unique_plant_list
      plants.distinct
   end

   def upcoming_harvest_list
      unique_plant_list.find_all do |plant|
         plant.days_to_harvest.to_i <= 100
      end
   end
end