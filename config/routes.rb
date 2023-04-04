Rails.application.routes.draw do
  resources :posts
  get '/my_posts', to: 'posts#my_posts'
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout

  root  "top#top"
  resources :users
  resource :profile, only: %i[show edit update]
  resources :words
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
