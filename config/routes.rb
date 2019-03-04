Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'tasks', to: 'tasks#tasks'
  resources :users
  resources :tasks, only: [:create, :destroy, :edit, :show, :update]
  resources :groups
  resources :groups do
    member do
      get :join
      get :defection
    end
  end
end
