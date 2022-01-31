# Frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
    describe 'バリデーションのテスト' do
        subject { post.valid? }
        
        let!(:user) { FactoryBot.build(:user) }
        let!(:post) { FactoryBot.build(:post, user_id: user.id) }

        context '料理名(cooking_name)カラム' do
            it '空欄でないこと' do
                post.cooking_name = ''
                is_expected.to eq false
            end
        end
        
        context '調理時間(cooking_time)カラム' do
            it '空欄でないこと' do
                post.cooking_time = ''
                is_expected.to eq false
            end
        end

    end
    
    describe 'アソシエーションのテスト' do
        context 'Userモデルとの関係' do
            it 'N：1になっている' do
                expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
    end
end
