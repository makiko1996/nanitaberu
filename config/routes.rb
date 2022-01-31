Rails.application.routes.draw do

  # 管理者用　URL /admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions",
  }

  # 会員用　URL /users/sign_in...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 管理者側のルーティング
  namespace :admin do
    resources :tastes, except: [:new, :show, :destroy]
    resources :categories, except: [:new, :show, :destroy]
    resources :tags, only: [:index] do
      patch :update_tag, on: :collection
      patch :withdrew_tag, on: :member
    end
  end

  # 会員側のルーティング
  scope module: :public do
    root 'homes#top'
    resources :posts do
      resources :favorites, only: [:index, :create, :destroy]
    end

    resources :users, only: [:show, :edit, :update] do
      get :favorites, on: :collection
    end
  end
end
