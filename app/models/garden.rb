class Garden < ApplicationRecord
   has_many :plots
   has_many :plants, through: :plots

   def ordered_plants_by_occurrence
      plants.joins(:plots).group('plants.id').order('COUNT(plots.id) DESC')
   end

   def upcoming_harvest_list
      ordered_plants_by_occurrence.where("plants.days_to_harvest::integer <= ?", 100)
   end
end