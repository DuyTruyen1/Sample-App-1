Rails.application.routes.draw do
  # Static pages
  root "static_pages#home"
  get "/help",    to: "static_pages#help"
  get "/about",   to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  # User authentication
  get    "/signup", to: "users#new"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Resources
  resources :users
  resources :account_activations, only: [ :edit ]
  resources :password_resets,     only: [ :new, :create, :edit, :update ]
  resources :microposts,          only: [ :create, :destroy ]

  # Active Storage (Rails tự thêm nếu bạn đã chạy active_storage:install)
  # Nếu bạn cần route custom, có thể thêm direct như sau (không cần thiết trong đa số trường hợp):
  # direct :rails_storage do |model, options|
  #   route_for(:rails_service_blob, model, options)
  # end
end
