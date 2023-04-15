Rails.application.routes.draw do
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  root  "top#top"
  get '/my_posts', to: 'posts#my_posts'
  resources :posts do
    resource :bookmarks, only: %i[create destroy]
    get 'bookmarks', on: :collection
  end
  resources :users
  resource :profile, only: %i[show edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
