class Garden < ApplicationRecord
   has_many :plots

   validates :name, presence: true
   validates :organic, presence: true, inclusion: { in: [true,false] }
end
