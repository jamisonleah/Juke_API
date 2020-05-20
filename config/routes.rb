Rails.application.routes.draw do
  get '/auth/spotify/callback/', to: 'user#spotify'
  root 'user#home'
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'user/info', to: 'user#info'

  
  # predefined RESTful Routes
  resources :party_queue, params: :party_code, path: '/parties/'
	


  # Get routes 
  get 'me/info', 		to: 'spotify#me' 
  get 'me/tracks', 		to: 'spotify#tracks'
  get 'me/spotify/refresh', 	to: 'application#refresh_token'
  get 'me/current', 		to: 'spotify#current'
  get 'me/partys', 		to: 'user#partys'
  get 'test/me', 		to: 'spotify#testmeout'
  get 'me/spotify',		to: 'user#spotify' 
  #partyqueues
  get 'parties/:party_code', 		to: 'party_queue#show'
  get 'party/join/:party_code', 	to: 'party_queue#join'
  get 'party/pending/:party_code', 	to: 'party_queue#pending'  
  get 'party/', 			to: 'party_queue#index'
  

  #Song Request
  get 'suggest/accept', 	to: 'queue_lobby#accept' 
  get 'suggest/deny',		to: 'queue_lobby#deny' 
  get 'suggest/priority',	to: 'queue_lobby#priority' 
  get 'suggest/request', 	to: 'queue_lobby#requestsong' 
  get 'search/:search_text', 	to: 'spotify#searchCenter'
  get 'refresh', 		to: 'application#check_refresh'	

  get 'search/:album_id/tracks', to: 'spotify#albumSearch'
  #Post routes
  post 'me/spotify/token_assign', 	to: 'application#spotify_access_token'
  post 'parties', 			to: 'party_queue#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
