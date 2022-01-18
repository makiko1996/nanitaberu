
# Categoryの新規登録テスト用データ作成
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number:6)}
  end
end