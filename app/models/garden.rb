class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots
   validates :name, presence: true
   validates :organic, presence: true, inclusion: { in: [true,false] }

   def plants_harvest_under_100_days
      plants.where("days_to_harvest < ?",100).distinct
   end

   # def sorted_plants
   #    plants
   #       .joins(:plot)
   #       .select("plants.id, plants.name, count(plots.plant_id) AS total_count")
   #       .group("plants.id")
   #       .order("total_count DESC")
   # end
end
