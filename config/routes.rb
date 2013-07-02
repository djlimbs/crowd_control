CrowdControl::Application.routes.draw do
  resources :artist_songs
  resources :songs
  resources :alt_names
  resources :artists
  devise_for :users, :controllers => { :registrations => "registrations" }
  devise_scope :user do
  	root to: 'devise/sessions#new'
  end
  
  resources :users
  match 'users', to: 'users#index', via: 'get'
  
  
  match '/home', to: 'static_pages#home', via: 'get'
  match '/djs', to: 'static_pages#djs', via: 'get'
  match '/guests', to: 'static_pages#guests', via: 'get'
  match '/couples', to: 'static_pages#couples', via: 'get'
end
