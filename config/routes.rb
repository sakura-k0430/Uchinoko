Rails.application.routes.draw do
  # 顧客用ログイン
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  # 管理者用ログイン
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   # 管理者側ルーティング
  namespace :admin do
    get '/' => 'customers#index'
    get '/articles/edit'
    resources :articles
    resources :hospitals
    resources :genres, only: [:edit, :update, :index, :create]
    resources :customers, only: [:edit, :update, :index, :show]
  end
  # 会員側ルーティング
  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"
    get 'customers/check'
    patch 'customers/withdraw'
    resources :customers, only:  [:show, :edit, :update]
    get '/search' => 'searches#search'
    get '/genre/search' => 'searches#genre_search'
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
