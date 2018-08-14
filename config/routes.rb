Rails.application.routes.draw do
  root 'product#index'
  resources :products
end
