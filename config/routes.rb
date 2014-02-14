Bueller::Application.routes.draw do
  resources :posts
  resources :sessions
  resources :attendances
  root to: "welcome#index"
  match '/signup',  to: 'sessions#index',       via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
