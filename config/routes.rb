Rails.application.routes.draw do
  
  get 'sessions/new'
  get 'users/new'
  root 'sessions#new'
  get '/help' => 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'
  resources :users
  get '/show' => 'images#show'
  get '/new' => 'images#new'
  get '/test_cloudinary', to: 'test#cloudinary_test'
  
  get '/likedpage' => 'swipes#likedpage'
  get '/swipes' => 'swipes#index'
  get 'matches', to: 'swipes#matches'
  resources :swipes do
    member do
      post :like
      post :dislike
    end
  end
  
  get '/messages/:id' => 'messages#show', as: 'messages'
  post '/messages/:id' => 'messages#create'
end



