FactoryBot.define do
  factory :order_destination do
    token { 'tok_abcdefghijklmnopqrstuvwxyz01' }
    postal_code { '123-4567' }
    prefecture_id { 14 }
    city { '中央区' }
    addresses { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }

    association :user_id
    association :item_id
  end
end
