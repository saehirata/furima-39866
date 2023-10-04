class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  belongs_to :user
  has_one_attached :image
  # has_many :comments
  has_one :order

  # 商品画像必須
  validates :image, presence: true

  # 商品名必須（文字数のバリデーションは不要）
  validates :name, presence: true

  # 商品の説明（文字数のバリデーションは不要）
  validates :info, presence: true

  # カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数「---」の時は保存できない
  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  # 販売価格必須
  validates :price, presence: true

  # 販売価格（¥300~¥9,999,999）：is out of setting range
  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                            message: 'は¥300〜9,999,999の範囲で設定してください' }

  # 販売価格（半角整数のみ）：is invalid. Input half-width characters
  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }
end
