Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'upload_invitation_file', to: 'files#create'
  get 'get_nearest_customers', to: 'customers#get_nearest_customers'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

    # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "amaha/sidekiq"
end
