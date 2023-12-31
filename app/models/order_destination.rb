class OrderDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :order_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :city
    validates :addresses
    validates :phone_number
    # 郵便番号は半角数字3桁、ハイフン、半角数字4桁の組み合わせでないと保存できない：is invalid. Enter it as follows (e.g. 123-4567)
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は次のようにハイフンを含めて入力してください（例：123-4567）' }
  end

  # 電話番号は半角数字しか保存できない：is invalid. Input only number.
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
  # 電話番号は10文字以上11文字以下でないと保存できない
  validates :phone_number, length: { in: 10..11, message: 'が短すぎます' }

  # 都道府県は「---」の時は保存できない
  validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }

  def save
    order = Order.create(user_id:, item_id:)
    Destination.create(postal_code:, prefecture_id:, city:, addresses:,
                       building:, phone_number:, order_id: order.id)
  end
end
