class Garden < ApplicationRecord
   has_many :plots
   has_many :plot_plants, through: :plots
   has_many :plants, through: :plot_plants

   def uniq_plants
    self.plants.distinct
   end

   def hundred_day_uniq_plants
    self.uniq_plants.where("plants.days_to_harvest < 100")
   end
end