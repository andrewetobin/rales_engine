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
        get '/random', to: 'merchant_random#show'
        get '/:id/items', to: 'items#show'
        get '/:id/invoices', to: 'invoices#show'
        get '/:id/revenue', to: 'single_merchant_revenue#show'
      end
      namespace :customers do
        get '/find', to: 'customer_search#show'
        get '/find_all', to: 'customer_search#index'
        get '/random', to: 'customer_random#show'
        get '/:id/invoices', to: 'invoices#show'
        get '/:id/transactions', to: 'transactions#show'


      end
      namespace :invoices do
        get '/find', to: 'invoice_search#show'
        get '/find_all', to: 'invoice_search#index'
        get '/random', to: 'invoice_random#show'
        get '/:id/transactions', to: 'transactions#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/items', to: 'items#show'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'


      end
      namespace :items do
        get '/find', to: 'item_search#show'
        get '/find_all', to: 'item_search#index'
        get '/random', to: 'item_random#show'
        get '/:id/merchant', to: 'merchant#show'
        get '/:id/invoice_items', to: 'invoice_items#show'


      end
      namespace :invoice_items do
        get '/find', to: 'invoice_item_search#show'
        get '/find_all', to: 'invoice_item_search#index'
        get '/random', to: 'invoice_item_random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'


      end
      namespace :transactions do
        get '/find', to: 'transaction_search#show'
        get '/find_all', to: 'transaction_search#index'
        get '/random', to: 'transaction_random#show'
        get '/:id/invoice', to: 'invoice#show'
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
