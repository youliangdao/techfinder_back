Rails.application.routes.draw do
  root  'rails/welcome#index'
  namespace :api, format: "json" do
    namespace :v1 do
      # api test action
      resources :hello, only:[:index]
      resource :authentication, only: %w[create]
    end
  end  
end
