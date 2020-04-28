Rails.application.routes.draw do
  get '/auth/spotify/callback/', to: 'user#spotify'
  root 'user#home'
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'user/info', to: 'user#info'

  #Post routes
  post 'user/spotify/token_assign', to: 'user#spotify_access_token'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
