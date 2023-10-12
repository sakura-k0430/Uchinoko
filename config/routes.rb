Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 顧客用ログイン
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # 管理者用ログイン
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   # 管理者側ルーティング
  namespace :admin do
    get '/' => 'customers#index'
    get '/articles/edit'
    resources :articles
    resources :hospitals
    resources :genres, only: [:edit, :update, :index, :create, :destroy]
    resources :customers, only: [:edit, :update, :index, :show]
  end
  # 会員側ルーティング
  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"
    get '/search' => 'searches#search'
    get '/genre/search' => 'searches#genre_search'
    get 'customers/followings_post'
    get 'customers/check'
    patch 'customers/withdraw'
    resources :customers, only:  [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      # お気に入り一覧にidが必要なためmemberを使用
      member do
        get :favorites
      end
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
      resource :group_customers, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end
    resources :articles, only: [:index, :show]
    resources :galleries do
      # idを含ませないresourceでルーティング作成（いいねを一人一回までとするため）
      resource :gallery_favorites, only: [:create, :destroy]
      resources :gallery_comments, only: [:create, :destroy]
    end
    resources :lost_pets do
       # idを含ませないresourceでルーティング作成（いいねを一人一回までとするため）
      resource :lost_pet_favorites, only: [:create, :destroy]
      resources :lost_pet_comments, only: [:create, :destroy]
    end
    resources :foster_parents do
      # idを含ませないresourceでルーティング作成（いいねを一人一回までとするため）
      resource :foster_parent_favorites, only: [:create, :destroy]
      resources :foster_parent_comments, only: [:create, :destroy]
    end
  end
end
