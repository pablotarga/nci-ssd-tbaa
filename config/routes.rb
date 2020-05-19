Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  get 'register' => 'users#new'

  resource :session, only: [:new, :create, :destroy]
  resource :user, only: [:show, :create, :update]

  resources :projects do
    resources :tasks, only: [] do
      put '/:status', action: 'update', on: :member, as: :change
    end
  end

  resources :tasks, only: [:index] do
    put '/:status', action: 'update', on: :member, as: :change
  end

  get '/about' => "pages#about"
  root "projects#index"

  mount ActionCable.server => '/cable'
end
