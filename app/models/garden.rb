class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def harvest_under_hundred_days
      plants.distinct.where("days_to_harvest < ?", 100)
   end
end