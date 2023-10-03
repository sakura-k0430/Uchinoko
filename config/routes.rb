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
  # 顧客側ルーティング
  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"
    get '/customers/mypage' => 'customers#show'
    get 'customers/check'
    get '/customers/edit'
    patch 'customers/withdraw'
    resource :customers, only:  [:update]
    get '/genre/search' => 'searches#genre_search'
    resources :articles, only: [:index, :show]
    get '/galleries/edit'
    resources :galleries, only: [:index, :show, :update, :destroy, :new, :create]
    get '/lost_pets/edit'
    resources :lost_pets, only: [:index, :show, :update, :destroy, :new, :create]
    get '/foster_parents/edit'
    resources :foster_parents, only: [:index, :show, :update, :destroy, :new, :create]
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
