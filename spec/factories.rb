# spec/factories.rb

FactoryBot.define do
  factory :garden do
    name { "My Garden" }
    organic { true }
  end

  factory :plot do
    number { 1 }
    size { "Small" }
    direction { "North" }
    garden
  end

  factory :plant do
    name { "Sunflower" }
    description { "A flower of the sun" }
    days_to_harvest { 50 }
    plot
  end
end
