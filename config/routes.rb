Rails.application.routes.draw do
  get "messages/new"
  get "messages/create"
  get "messages/index"
  get "messages/show"
  devise_for :users

  get "admin/index"

  namespace :admin do
    resources :t_shirts do
      member do
        delete :destroy
        patch :toggle_hidden
        get :toggle_hidden
        get :adjuct_stock
        patch :update_stock
      end
      resources :opinions, only: [:create, :destroy]
    end
    resources :messages, only: [:index, :show, :update]
  end
  
  root "t_shirts#index"

  resources :t_shirts do
    resources :opinions, only: [:create, :destroy, :update, :edit]
  end

  resources :cart_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show, :destroy]
  resources :messages, only: [:new, :create, :index, :show]

  resources :carts do
    member do
      post :checkout
    end
  end

  resource :cart, only: [:show, :destroy, :update] do
    get 'pay'
    post 'process_payment'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
