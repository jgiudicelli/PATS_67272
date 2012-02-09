PATS67272::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  # Authentication routes
  match 'user/edit' => 'users#edit', :as => :edit_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  resources :sessions
  resources :users
  
  # Generated model routes
  resources :owners
  resources :animals
  resources :pets
  resources :visits
  resources :vaccines
  resources :vaccinations
  
  # Semi-static page routes
  match 'home' => 'home#index', :as => :home
  match 'about' => 'home#about', :as => :about
  match 'contact' => 'home#contact', :as => :contact
  match 'privacy' => 'home#privacy', :as => :privacy
  match 'search' => 'home#search', :as => :search
  
  # Set the root url
  root :to => 'home#index'
end
