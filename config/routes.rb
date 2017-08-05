Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api/1' do
    resources :routes, only: [:index]
    resources :walks, only: [:create]
    post '/register_steps', to: 'steps#register_steps'
  end
end
