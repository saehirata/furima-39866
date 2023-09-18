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
  # has_one :order

  # 商品画像必須
  validates :image, presence: true

  # 商品名必須（文字数のバリデーションは不要）
  validates :name, presence: true

  # 商品の説明（文字数のバリデーションは不要）
  validates :info, presence: true

  # カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数「---」の時は保存できない
  with_options numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  # 販売価格必須
  validates :price, presence: true

  # 販売価格（¥300~¥9,999,999）
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 , message: "is out of setting range"}

  # 販売価格（半角数字のみ）
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }

end
