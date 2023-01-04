Rails.application.routes.draw do
  root  'rails/welcome#index'
  namespace :api, format: "json" do
    namespace :v1 do
      # api test action
      resources :hello, only: %w[index]
      resource :image, only: %w[create show]
      resource :authentication, only: %w[create]
      resource :profile, only: %w[show update]
      resources :articles, only: %w[index] do
        collection do
          get 'rising', to: 'articles#rising'
        end
      end
      scope '/:category_name' do
        get 'articles', to: 'category/articles#index'
      end
      resources :categories, only: %w[index] do
        collection do
          get 'popular', to: 'categories#popular'
        end
      end
      get 'categories/:category_name', to: 'categories#show'
    end
  end  
end
