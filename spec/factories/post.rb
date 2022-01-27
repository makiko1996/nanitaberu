FactoryBot.define do
  factory :post do
    cooking_name { Faker::Lorem.characters(number: 10) }
    category_id { Faker::Number.between(to: 5) }
    image_id { Faker::Lorem.characters(number: 20) }
    cooking_time { Faker::Number.between(to: 30) }
    difficulty { Faker::Number.between(to: 3) }
    taste_id { Faker::Number.between(to: 5) }
    user_id { Faker::Number.between(from: 1) }
  end
end
