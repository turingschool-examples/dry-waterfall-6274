class Garden < ApplicationRecord
   has_many :plots
   has_many :plot_plants, through: :plots
   has_many :plants, through: :plot_plants

   def unique_fast_growing_plants_by_occurance
      plants.select("plants.*, COUNT(plot_plants.plant_id)")
      .where("plants.days_to_harvest < 100")
      .order("COUNT(plot_plants.plant_id) DESC")
      .group("plants.id")
      .distinct
   end

end