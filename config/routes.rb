Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  
  resources :users

  resources :contacts do
    post 'reply', on: :member
  end
  
  resources :videos, only: [:show, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
    resources :reports, only: [:create, :destroy]
  end

 # ścieżki główne dla różnych typów użytkowników
 authenticated :user, -> user { user.admin? } do
  resources :admins, only: [:users, :destroy, :all]
  root 'admins#index', as: :admin_root
end

authenticated :user, -> user { user.premium? } do
  root 'premium_users#index', as: :premium_root
end

authenticated :user do
  root 'standard_users#index', as: :authenticated_root
end


  root "main#index"


  #main
  get "ind", to: "main#index", as: "ind"
  get "log", to: "main#log", as: "log"
  get "help", to: "main#help", as: "help"
  get "reg", to: "main#reg", as: "reg"
  get "search_main", to: "main#search", as: "search_main"


  #admin
  get "aind", to: "admins#index", as: "aind"
  get "ahelp", to: "admins#help", as: "ahelp"
  get "usr", to: "admins#users", as: "usr"
  get "all", to: "admins#all", as: "all"
  get "rep", to: "admins#reports", as: "rep"
  get "set", to: "admins#settings", as: "set"
  get '/moon', to: 'admins#moon', as: 'moon'
  get '/sun', to: 'admins#sun', as: 'sun'

  #standard_user
  get "uind", to: "standard_users#index", as: "uind"
  get "prof", to: "standard_users#profile", as: "prof"
  get "prem", to: "standard_users#premium", as: "prem"
  get "adm", to: "standard_users#add_movie", as: "adm"
  get "uhelp", to: "standard_users#help", as: "uhelp"
  post 'uhelp', to: 'standard_users#new'

  #premium_user
  get "pind", to: "premium_users#index", as: "pind"
  get "profp", to: "premium_users#profile", as: "profp"
  get "add_premium", to: "premium_users#add", as: "add_premium"
  get "phelp", to: "premium_users#help", as: "phelp"
  post 'phelp', to: 'premium_users#new'


  get "profil", to: "users#profile", as: "profile"

  get "test", to: "videos#new_premium", as: "test"
  #search functionality routes
  get 'search', to: 'search#index'

  resources :users, only: [:show] do
    member do
      get 'profile'
    end
  end

  get 'userp/:id', to: 'users#profile', as: 'userp'


  get 'videos/:id/download', to: 'videos#download', as: 'download_video'
  
  get 'new_standard_video', to: 'videos#new_standard', as: 'new_standard_video'

  get 'new_premium_video', to: 'videos#new_premium', as: 'new_premium_video'

end
