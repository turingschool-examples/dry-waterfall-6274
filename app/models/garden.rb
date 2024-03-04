class Garden < ApplicationRecord
   has_many :plots

   def self.one_hundred_or_less_harvest_days
      Garden
            .joins(plots: :plants)
            .where('plants.days_to_harvest < ?', 100)
            .distinct
   end
end