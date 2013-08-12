CrowdControl::Application.routes.draw do
  resources :artists do
  	collection { post :import }
  end
  resources :songs do
  	collection { post :import }
  end
  resources :alt_names
  resources :charts
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
  
  match '/home', to: 'static_pages#home', via: 'get'
  match '/djs', to: 'static_pages#djs', via: 'get'
  match '/guests', to: 'static_pages#guests', via: 'post'
  match 'guest_artist_search', to: 'songs#guest_artist_search', via: 'get'
  match 'guest_song_search', to: 'songs#guest_song_search', via: 'get'
  match '/couples', to: 'static_pages#couples', via: 'get'
  match 'get_chart', to: 'static_pages#get_chart', via: 'get'
end
