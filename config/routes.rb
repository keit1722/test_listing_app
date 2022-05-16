Rails.application.routes.draw do
  root 'pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  namespace :mypage do
    get 'profile', to: 'users#show'
    get 'profile/edit', to: 'users#edit'
    patch 'profile', to: 'users#update'
    delete 'profile', to: 'users#destroy'
  end

  resources :organizations, param: :slug
end
