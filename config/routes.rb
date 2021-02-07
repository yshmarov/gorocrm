Rails.application.routes.draw do
  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "static_public#landing_page"
  get "about", to: "static_public#about"
  get "pricing", to: "static_public#pricing"
  get "privacy", to: "static_public#privacy"
  get "terms", to: "static_public#terms"

  authenticated :user, lambda { |u| u.superadmin? } do
    scope :superadmin, as: "superadmin" do
      root "superadmin#dashboard"
      get "tenants", to: "superadmin#tenants"
      get "users", to: "superadmin#users"
      get "charges", to: "superadmin#charges"
      get "subscriptions", to: "superadmin#subscriptions"
    end
    scope :superadmin do
      resources :plans
    end
  end

  resources :users, only: [:show] do
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    member do
      patch :switch
    end
  end

  resources :subscriptions, only: [:create, :destroy]
  resources :charges, only: [:create]

  resources :members, except: [:create, :new] do
    get :invite, on: :collection
  end

  get "dashboard", to: "tenant#dashboard"
  get "calendar", to: "tenant#calendar"
  get "feed", to: "tenant#feed"
  get "charts", to: "tenant#charts"
  get "tasks_report", to: "tenant#tasks_report"
  resources :clients do
    resources :comments
  end
  resources :payments
  resources :tasks do
    member do
      patch :change_status
    end
    resources :comments
  end
  resources :projects
  resources :tags
  resources :cash_accounts
  
end
