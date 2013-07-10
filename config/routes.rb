CrowdControl::Application.routes.draw do
  resources :artist_songs
  resources :songs
  resources :alt_names
  resources :artists
  resources :votes
  
  devise_for :users, :controllers => { :registrations => "registrations" } do
  	post 'users', :to => 'users#create'
  end
  devise_scope :user do
  	root to: 'devise/sessions#new'
  	match '/guests', to: 'devise/sessions#new', via: 'get'
  end
  
  resources :users
  match 'users', to: 'users#index', via: 'get'
  match 'guest_search', to: 'songs#guest_search', via: 'get'
  
  match '/home', to: 'static_pages#home', via: 'get'
  match '/djs', to: 'static_pages#djs', via: 'get'
  match '/guests', to: 'static_pages#guests', via: 'post'
  match '/couples', to: 'static_pages#couples', via: 'get'
end
