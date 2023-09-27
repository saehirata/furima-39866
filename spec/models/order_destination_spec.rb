require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入' do
    context '商品が購入できる場合' do
      it '必要事項を全て過不足なく入力すると購入できる' do
        expect(@order_destination).to be_valid
      end

      it '建物名のみ空欄でも購入できる' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'tokenが空だと購入できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空だと購入できない' do
        @order_destination.postal_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号にハイフンが含まれていないと購入できない' do
        @order_destination.postal_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が「---」では購入できない' do
        @order_destination.prefecture_id = '1'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと購入できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @order_destination.addresses = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Addresses can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @order_destination.phone_number = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号に半角数字以外が含まれていると購入できない' do
        @order_destination.phone_number = '０１２３４５６７ああ'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid. Input only number.')
      end

      it '電話番号が10桁未満だと購入できない' do
        @order_destination.phone_number = '090123456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is too short')
      end

      it '電話番号が12桁以上だと購入できない' do
        @order_destination.phone_number = '090123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is too short')
      end

      it 'user_idが紐づいていなければ購入できない' do
        @order_destination.user_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが紐づいていなければ購入できない' do
        @order_destination.item_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
