CrowdControl::Application.routes.draw do
  resources :alt_names
  resources :artists
  devise_for :users
  root to: 'static_pages#couples'
  
  match '/home', to: 'static_pages#home', via: 'get'
  match '/djs', to: 'static_pages#djs', via: 'get'
  match '/guests', to: 'static_pages#guests', via: 'get'
  match '/couples', to: 'static_pages#couples', via: 'get'
end
