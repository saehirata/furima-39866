FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name   { 'やマ田' }
    first_name  { '太ろウ' }
    last_name_kana  { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birth_date { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
