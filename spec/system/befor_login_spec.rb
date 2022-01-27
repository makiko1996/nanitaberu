require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '投稿一覧へのリンク表示があるか' do
        byebug
        post_index_link = find_all('a')[3].native.inner_text
        expect(page).to have_link post_index_link, href: posts_path
      end
    end
  end

  describe 'ログイン画面のテスト' do
    before do
      visit new_user_session_path
    end

    context 'URLが正しい' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end
end