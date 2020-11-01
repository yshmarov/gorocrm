Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  root "static_pages#landing_page"
  get "about", to: "static_pages#about"
  get "pricing", to: "static_pages#pricing"
  get "privacy", to: "static_pages#privacy"
  get "terms", to: "static_pages#terms"

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
  get "dashboard", to: "tenant#dashboard"

  resources :subscriptions, only: [:create, :destroy]
  resources :charges, only: [:create, :show]

  resources :members, except: [:create, :new] do
    get :invite, on: :collection
  end

  get "/contacts/:provider/contact_callback", to: "contacts#import"
  get "/contacts/failure", to: "contacts#failure"
  resources :contacts
  # get ":tenant_id", to: 'leads#new', as: :new_lead #short url option
  # get "t/:tenant_id/l/n", to: 'leads#new', as: :new_lead #short url option
  get "tenants/:tenant_id/leads/new", to: "leads#new", as: :new_lead
  get "tenants/:tenant_id/leads/:id", to: "leads#show", as: :tenant_lead
  match "tenants/:tenant_id/leads", to: "leads#create", via: [:post], as: :create_lead
end
