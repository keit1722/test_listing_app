Rails.application.routes.draw do
  root 'pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  namespace :mypage do
    get 'profile', to: 'users#show'
    patch 'profile', to: 'users#update'
    delete 'profile', to: 'users#destroy'
    get 'profile/edit', to: 'users#edit'
  end

  resources :organizations, param: :slug do
    scope module: :organization do
      resources :restaurants, param: :slug
      resources :shops, param: :slug
      resources :hotels, param: :slug
      resources :activities, param: :slug
    end
  end

  resources :restaurants, param: :slug, only: %i[index show]
  resources :shops, param: :slug, only: %i[index show]
  resources :hotels, param: :slug, only: %i[index show]
  resources :activities, param: :slug, only: %i[index show]
end
