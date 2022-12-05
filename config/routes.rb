Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "homes#top"
  get "homes/about", to: "homes#about"
  get "homes/index", to: "homes#index"
  # 学習理解度を更新するため
  patch 'users/:id/change_comprehension' => 'completes#change_comprehension', as: 'change_comprehension'
  
  # devise lineログインのため
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  
  resources :users, only: %i[show edit update destroy] do
    resources :categories, only: %i[index create update destroy]
    resources :study_records
    resources :completes, only: %i[index show]
  end
end
