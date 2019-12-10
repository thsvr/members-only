Rails.application.routes.draw do
  get '/sign-up',  to: 'users#new'
  post '/sign-up', to: 'users#create'
  get 'posts/new'
  post 'posts/create'
  get 'posts/index'
  get 'posts/show'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'posts#index'
 
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
