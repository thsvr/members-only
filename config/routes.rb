Rails.application.routes.draw do
  get '/sign-up',  to: 'users#new'
  post '/sign-up', to: 'users#create'  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'posts#index'
  resources :posts, only: [:new, :create, :index, :show]
 
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
