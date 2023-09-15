class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # has_many :items
  # has_many :orders
  # has_many :comments

  validates :nickname, presence: true

  # PW（半角英数）
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'Password is invalid. Include both letters and numbers'
  
  # お名前(全角/漢字・ひらがな・カタカナ)
  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' } do
    validates :first_name
    validates :last_name
  end
 
  # お名前カナ(全角/カタカナ)
  with_options presence: true, format: { with: /\A[ァ-ヴー]+\z/, message: 'is invalid. Input full-width katakana characters' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  # 生年月日
  validates :birth_date, presence: true
end
