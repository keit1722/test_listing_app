Rails.application.routes.draw do
  root 'pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
end
