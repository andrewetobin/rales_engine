Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'merchant_revenue#index'
        get '/revenue', to: 'merchant_revenue#show'
        get '/most_items', to: 'merchant_items_count#index'
        get '/find', to: 'merchant_search#show'
        get '/find_all', to: 'merchant_search#index'
      end
      namespace :customers do
        get '/find', to: 'customer_search#show'
        get '/find_all', to: 'customer_search#index'
      end

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end

end
