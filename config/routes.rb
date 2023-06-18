Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "articles#index"
  scope module: 'api', path: 'api' do
    namespace :v1 do
      post 'users/register', to: 'users#register'
      post 'users/login' => 'users#login'
      get 'users/logout', to: 'users#logout'
      post 'users/refresh' => 'users#refresh'
      get 'users/theme', to: 'themes#show'
      post 'users/theme/update' => 'themes#update'

      post 'cryptos/delete/multiple', to: 'cryptos#destroy_multiple'

      resources :cryptos
      resources :crypto_types
      resources :users
    end
  end
end
