Rails.application.routes.draw do
  root  'rails/welcome#index'
  namespace :api, format: "json" do
    namespace :v1 do
      # api test action
      resources :hello, only: %w[index]
      resource :image, only: %w[create show]
      resource :authentication, only: %w[create]
      resource :profile, only: %w[show update]
    end
  end  
end
