Rails.application.routes.draw do
  root  'rails/welcome#index'
  namespace :api do
    namespace :v1 do
      # api test action
      resources :hello, only:[:index]
    end
  end  
end
