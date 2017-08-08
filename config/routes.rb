Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  root to: 'frontend/homepage#index'
  scope module: 'frontend' do
    resource :sessions, only: %i[new create] do
      get '/logout', to: 'sessions#destroy', as: :logout
    end
    resources :walks, only: %i[index]
    resources :routes, only: %i[index show]
  end

  scope '/api', module: 'api' do
    scope '/1', module: 'v1' do
      resources :routes, only: %i[index]
      resources :walks, only: %i[create]
      post '/register_steps', to: 'steps#register_steps'
    end
  end
end
