Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :invoice_details
  # resources :invoices
  get 'invoices', to: 'invoices#index'
  get 'invoices/:invoice_id', to: 'invoices#show', as: 'invoice'
  get 'invoices/:invoices_id/edit', to: 'invoices#edit', as:'edit_invoice'
  resources :members
  # resources :groups, except: [:destroy]
  get 'groups', to: 'groups#index'
  get '/groups/:group_id', to: 'groups#show', as: 'group'
  get 'groups/:group_id/edit', to: 'groups#edit', as: 'edit_group'
  # PDF出力
  get '/pdf-download/:id', to: 'pdf#download', as: 'pdf_download', :format => 'pdf'
  get 'pdf-show/:id' => 'pdf#show', as: 'pdf_show', :format => 'pdf'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
