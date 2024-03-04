class Garden < ApplicationRecord
   has_many :plots

   def plants_with_short_harvest_time
      Plant.where(plot: plots).where("days_to_harvest < ?", 100).distinct
   end
end