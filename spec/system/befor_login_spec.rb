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
      it 'ロゴ画像にトップページのリンク表示がある' do
        logo_link = find_all('a')[0].native.attributes['href'].value
        expect(logo_link).to eq '/'
      end
      it '投稿一覧へのリンク表示があるか' do
        post_index_link = find_all('a')[1].native.inner_text
        expect(page).to have_link post_index_link, href: posts_path
      end
      it '新規登録へのリンク表示があるか' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
      it 'ログインへのリンク表示があるか' do
        sign_in_link = find_all('a')[3].native.inner_text
        expect(page).to have_link sign_in_link, href: new_user_session_path
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it '投稿一覧を押すと一覧画面に遷移する' do
        post_index_link = find_all('a')[1].native.inner_text
        post_index_link.gsub!(/\n/, '')
        click_link post_index_link
        is_expected.to eq posts_path
      end
      it '新規登録を押すと新規登録画面に遷移する' do
        sign_up_link = find_all('a')[2].native.inner_text
        sign_up_link.gsub!(/\n/, '')
        click_link sign_up_link
        is_expected.to eq new_user_registration_path
      end
      it 'ログインを押すとログイン画面に遷移する' do
        sign_in_link = find_all('a')[3].native.inner_text
        sign_in_link.gsub!(/\n/, '')
        click_link sign_in_link
        is_expected.to eq new_user_session_path
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
  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end

    context 'URLが正しい' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
    end
  end
end

describe 'ユーザー新規登録のテスト' do
  before do
    visit new_user_registration_path
  end

  context '表示内容の確認' do
    it '「新規会員登録」と表示される' do
      expect(page).to have_content '新規会員登録'
    end
    it '名前フォームが表示される' do
    
    end
    it 'メールアドレスフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'パスワードが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'パスワード(確認用)が表示される' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it '「新規会員登録」ボタンが表示される' do
      expect(page).to have_button '会員登録'
    end
  end
  context '登録成功のテスト' do
    before do
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 8)
      fill_in 'user[email]', with: Faker::Internet.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    it '正しく新規登録ができる' do
      expect { click_button '会員登録' }.to change(User.all, :count).by(1)
    end
    it '登録後トップ画面に遷移する' do
      click_button '会員登録'
      expect(current_path).to eq '/'
    end
  end
end
describe 'ユーザーログイン' do
  let(:user) { FactoryBot.build(:user) }
  
  before do
    visit new_user_session_path
  end
  
  context '表示内容の確認' do
    it '「ログイン」と表示される' do
      expect(page).to have_content 'ログイン'
    end
    it 'メールアドレスフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'パスワードが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it '「ログイン登録」ボタンが表示される' do
      expect(page).to have_button 'ログイン'
    end
    it '名前フォームが表示されされない' do
      expect(page).not_to have_field 'user[name]'
    end
  end
  context 'ログイン成功のテスト' do
    before do
      visit new_user_registration_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button '会員登録'
    end

    it 'ログイン後トップ画面に遷移する' do
      log_out_link = find_all('a')[5].native.inner_text
      log_out_link.gsub!(/\n/, '')
      click_link log_out_link
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      expect(current_path).to eq '/'
    end
    it 'ログアウトのテスト' do
      log_out_link = find_all('a')[5].native.inner_text
      log_out_link.gsub!(/\n/, '')
      click_link log_out_link
      expect(user.id).to eq nil
    end
  end
  context 'ログイン失敗のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq new_user_session_path
    end
  end
end