# Frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    subject { user.valid? }
    
    let(:user) { FactoryBot.build(:user) }
    
    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '１：Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end
