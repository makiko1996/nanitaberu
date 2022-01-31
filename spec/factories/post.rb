FactoryBot.define do
  factory :post do
    cooking_name { Faker::Lorem.characters(number: 10) }
    image_id { Faker::Lorem.characters(number: 20) }
    cooking_time { Faker::Number.between(to: 30) }
  end
end
