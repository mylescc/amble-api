Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'frontend/walks#index'

  scope module: 'frontend' do
    resource :sessions, only: %i[new create] do
      get '/logout', to: 'sessions#destroy', as: :logout
    end
    resources :walks, only: %i[index]
  end

  scope '/api', module: 'api' do
    scope '/1', module: 'v1' do
      resources :routes, only: [:index]
      resources :walks, only: [:create]
      post '/register_steps', to: 'steps#register_steps'
    end
  end
end
