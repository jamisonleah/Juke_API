class SpotifyController < ApplicationController
	require 'httparty'
	
	
	def me
	    # wanted it to be easy to view 
	    header = "Bearer " + current_user.spotify_account_token
	    response = HTTParty.get("https://api.spotify.com/v1/me", 
				    { headers: { "Authorization" => header }
	    			    })
	    render json: response, status: :ok 

	end

end
