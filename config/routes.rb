Rails.application.routes.draw do
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  root  "top#top"
  get '/my_posts', to: 'posts#my_posts'
  resources :posts do
    resource :bookmarks, only: %i[create destroy]
    get 'bookmarks', on: :collection
    resource :word_memories, only: %i[create destroy]
    resource :line_posts, only: %i[create destroy]
    get 'line_relations', on: :collection
    get 'set_time', on: :member
    patch 'update_time', on: :member
  end
  resources :users
  resource :profile, only: %i[show edit update]
  post '/callback', to: 'line_bot#callback'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end