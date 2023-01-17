Rails.application.routes.draw do
  root  'rails/welcome#index'
  namespace :api, format: "json" do
    namespace :v1 do
      resource :image, only: %w[create show]
      get 'images/:user_id', to: 'images#avatar'
      resource :authentication, only: %w[create]
      resource :profile, only: %w[show update]
      resources :articles, only: %w[index] do
        resources :comments, only: %w[index create destroy update], shallow: true
        resources :likes, only: %w[index]
        resources :bookmarks, only: %w[index]
        collection do
          get 'rising', to: 'articles#rising'
          get 'bookmarks', to: 'articles#bookmarks'
          get 'likes', to: 'articles#likes'
          get 'comments', to: 'articles#comments'
          get 'bookmarks_and_comments', to: 'articles#bookmark_comments'
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
      resources :bookmarks, only: %w[create destroy]
      resources :likes, only: %w[create destroy]
    end
  end  
end
