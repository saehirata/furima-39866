class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  # has_many :comments

  validates :nickname, presence: true

  # PW（半角英数）：Password is invalid. Include both letters and numbers
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  
  # お名前(全角/漢字・ひらがな・カタカナ)：is invalid. Input full-width characters
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字で入力してください' } do
    validates :first_name
    validates :last_name
  end

  # お名前カナ(全角/カタカナ)：is invalid. Input full-width katakana characters
  with_options presence: true, format: { with: /\A[ァ-ヴー]+\z/, message: 'は全角カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # 生年月日
  validates :birth_date, presence: true
end
