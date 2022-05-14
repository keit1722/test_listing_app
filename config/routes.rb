Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  resources :users, only: %i[create]
end
