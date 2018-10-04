Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'merchant_revenue#index'
        get '/revenue', to: 'merchant_revenue#show'
        get '/most_items', to: 'merchant_items_count#index'
      end

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end

end
