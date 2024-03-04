class Plot < ApplicationRecord
   belongs_to :garden
   has_many :plants
end
