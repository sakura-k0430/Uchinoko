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
  # 会員側ルーティング
  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"
    get 'customers/check'
    patch 'customers/withdraw'
    resources :customers, only:  [:show, :edit, :update]
    get '/genre/search' => 'searches#genre_search'
    resources :articles, only: [:index, :show]
    resources :galleries do
      resources :gallery_comments, only: [:create, :destroy]
    end
    resources :lost_pets do
      resources :lost_pet_comments, only: [:create, :destroy]
    end
    resources :foster_parents do
      resources :foster_parent_comments, only: [:create, :destroy]
    end
  end
  # 管理者側ルーティング
  namespace :admin do
    get '/' => 'customers#index'
    get '/articles/edit'
    resources :articles, only: [:index, :show, :update, :destroy, :new, :create]
    resources :hospitals
    resources :genres, only: [:edit, :update, :index, :create]
    resources :customers, only: [:edit, :update, :index, :show]
  end
end
