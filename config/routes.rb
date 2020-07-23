Rails.application.routes.draw do

  resources :contacts
  devise_for :users

  root 'static_pages#landing_page'
  get 'about', to: 'static_pages#about'
  get 'pricing', to: 'static_pages#pricing'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'

  get 'dashboard', to: 'home#dashboard'
  
  resources :users, only: [:index, :show] do
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    get :my, on: :collection
    member do
      patch :switch
    end
  end

  resources :members, except: [:create, :new] do
    get :invite, on: :collection
  end

end
