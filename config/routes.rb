Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root 'home#index'
  
  resources :users, only: [:index, :show] do
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    get :my, on: :collection
  end

  resources :members, except: [:create, :new] do
    get :invite, on: :collection
  end

end
