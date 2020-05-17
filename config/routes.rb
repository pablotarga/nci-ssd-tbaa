Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  get 'register' => 'users#new'

  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:show, :create, :update]
  resources :projects

  get '/about' => "pages#about"
  root "projects#index"
end
