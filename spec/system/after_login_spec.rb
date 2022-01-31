require 'rails_helper'

describe 'ユーザーログイン後のテスト' do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  # let(:user) { user }
  
  describe 'ヘッダーのテスト ログインしている場合' do
    context 'リンクの内容を確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ロゴ画像にトップページのリンク表示がある' do
        logo_link = find_all('a')[0].native.attributes['href'].value
        expect(logo_link).to eq '/'
      end
      it 'マイページへのリンク表示があるか' do
        user_link = find_all('a')[1].native.inner_text
        expect(page).to have_link user_link, href: user_path(user)
      end
      it '新規投稿へのリンク表示があるか' do
        new_post_link = find_all('a')[2].native.inner_text
        expect(page).to have_link new_post_link, href: new_post_path
      end
      it '投稿一覧へのリンク表示があるか' do
        post_index_link = find_all('a')[3].native.inner_text
        expect(page).to have_link post_index_link, href: posts_path
      end
      it 'お気に入りへのリンク表示があるか' do
        favorite_link = find_all('a')[4].native.inner_text
        expect(page).to have_link favorite_link, href: '/posts/' + user.id.to_s + '/favorites'
      end
      it 'ログアウトへのリンク表示があるか' do
        log_out_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_out_link, href: destroy_user_session_path
      end
    end
  end
  describe 'リンクの内容を確認※登校一覧とログアウトはログインチェック時に確認済' do
    subject { current_path }
    
    it 'マイページを押すとマイページに遷移する' do
      my_page_link = find_all('a')[1].native.inner_text
      my_page_link.gsub!(/\n/, '')
      click_link my_page_link
      is_expected.to eq user_path(user)
    end
    it '新規投稿を押すと新規投稿画面に遷移する' do
      new_post_link = find_all('a')[2].native.inner_text
      new_post_link.gsub!(/\n/, '')
      click_link new_post_link
      is_expected.to eq new_post_path
    end
    it 'お気に入りを押すとお気に入り画面に遷移する' do
      favorite_post_link = find_all('a')[4].native.inner_text
      favorite_post_link.gsub!(/\n/, '')
      click_link favorite_post_link
      is_expected.to eq '/posts/' + user.id.to_s + '/favorites'
    end
  end
  describe '新規投稿のテスト' do
    let!(:category) { create(:category) }
    let!(:taste) { create(:taste) }
    before do
    visit new_post_path
    end
    
    context '表示内容の確認' do
      it '料理名フォームがあるか' do
        expect(page).to have_field 'post[cooking_name]'
      end
      it '画像投稿フォームがあるか' do
        expect(page).to have_field 'post[image]'
      end
      it '食材フォームがあるか' do
        expect(page).to have_field 'post[tag_name]'
      end
      it 'カテゴリフォームがあるか' do
        expect(page).to have_field 'post[category_id]'
      end
      it '調理時間フォームがあるか' do
        expect(page).to have_field 'post[cooking_time]'
      end
      it 'オモさフォームがあるか' do
        expect(page).to have_select 'post[taste_id]'
      end
      it '参考レシピURLフォームがあるか' do
        expect(page).to have_field 'post[url]'
      end
    end
    context '登録成功のテスト' do
      before do
        fill_in 'post[cooking_name]', with: Faker::Lorem.characters(number: 10)
        attach_file 'post[image]', "#{Rails.root}/spec/fixtures/images/test.png"
        fill_in 'post[tag_name]', with: Faker::Lorem.characters(number: 5)
        select "#{ category.name }", from: 'post[category_id]'
        fill_in 'post[cooking_time]', with: Faker::Number.between(to: 30) 
        select "#{ taste.name }", from: 'post[taste_id]'
      end
      it '正しく新規登録ができる' do
        expect { click_button '新規投稿' }.to change(Post.all, :count).by(1)
      end
      it 'リダイレクト先が、一覧画面になっている' do
        click_button '新規投稿'
        expect(current_path).to eq '/posts'
      end
    end
  end
  describe 'マイページのテスト' do
    before do
      visit user_path(user)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '「ユーザー名の投稿」と表示される' do
        expect(page).to have_content "#{ user.name }の投稿"
      end
      it 'ユーザー編集のリンクがある' do
        user_edit_link = find_all('a')[6].native.inner_text
        expect(page).to have_link user_edit_link, href: '/users/' + user.id.to_s + '/edit'
      end
    end
  end
end
