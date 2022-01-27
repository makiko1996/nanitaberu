# Tasteの新規登録用テストデータ作成
FactoryBot.define do
  factory :taste do
    name { Faker::Lorem.characters(number: 5) }
  end
end