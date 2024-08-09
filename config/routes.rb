Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :files_handler do
    post 'upload_invitation_file', to: 'files_handler#create'
  end 

  namespace :customers do
    get 'get_nearest_customers', to: 'customers#get_nearest_customers'
  end 
  
  
  require 'sidekiq/web'
  
  require 'sidekiq/cron/web'

  # mount Sidekiq::Web in your Rails app
  mount Sidekiq::Web => "amaha/sidekiq"
end
