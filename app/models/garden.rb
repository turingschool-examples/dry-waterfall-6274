class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def unique_plant_list
      plants.distinct
   end

   def upcoming_harvest_list
      unique_plant_list.where("plants.days_to_harvest::integer <= ?", 100)
   end
end