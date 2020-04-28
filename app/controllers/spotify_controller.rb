class SpotifyController < ApplicationController
	require 'httparty'
	require 'base64'
	before_action :authenticate_user!
	

	##
	# refresh_token refreshes a current_users token for spotify 
	# when that token can no longer be used 
	# when completed it returns the current_user as a JSON object 
	# if an issue occuers it will render a bad_request 
	def refresh_token
	   #4. Requesting a refreshed access token; Spotify returns a new access token to your app
		base = "Basic " +  Base64.encode64("#{client_id}:#{client_secret}")
		#I don't know why but there's '\n' characters in the base so I removed them 0
			    headers =
			    {
				"Authorization" => base.gsub("\n",""),
				'Content-Type' => 'application/x-www-form-urlencoded'
			    }
			    	    
  			   body =  "grant_type=refresh_token&refresh_token=#{current_user.spotify_refresh}"
		 	    
	   response = HTTParty.post("https://accounts.spotify.com/api/token", :headers => headers, :body => body)
	   jsonResponse = JSON.parse(response.body, symbolize_names: true) #=> {key: :value}
	   case response.code
	        when 200
			current_user.spotify_account_token = jsonResponse[:access_token]
			current_user.save!
	   		render json: current_user, status: :ok 
		else
			render status: :bad_request
		end


	end
	def me
	    # wanted it to be easy to view 
	    response = HTTParty.get("https://api.spotify.com/v1/me", 
				    { headers: { "Authorization" => auth_header }
	    			    })
	    render json: response, status: :ok 

	end
	def tracks
	    response = HTTParty.get( user_track_path, 
				{ headers: { "Authorization" => auth_header }
	    			})    
	    render json: response, status: :ok
	end

	private 
	def client_id
		return "2b0942fbe4e4477fa8bd23bbec99acfa"
	end
	def client_secret
		return "a73a5a27b1df4286a8dd28e82658366f"
	end


	def spotify_response

	end

	def auth_header
	   return  header = "Bearer " + current_user.spotify_account_token
	end

	def user_info_path 
	    return "https://api.spotify.com/v1/me/tracks"
	end

	def user_track_path
	    return "https://api.spotify.com/v1/me/tracks"
	end
		
	


end
