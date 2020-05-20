class ApplicationController < ActionController::API
        #protect_from_forgery unless: -> { request.format.json? }
	include DeviseTokenAuth::Concerns::SetUserByToken
	

	#used by all controllers so I put it in here 
	def auth_header
	   return  header = "Bearer " + current_user.spotify_account_token
	end

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
		 	    
	   			response = HTTParty.post("https://accounts.spotify.com/api/token", :headers => headers,:body => body)
	   			jsonResponse = JSON.parse(response.body, symbolize_names: true) #=> {key: :value}
	   		
			
				case response.code
	        		when 200
					current_user.spotify_account_token = jsonResponse[:access_token]
					current_user.save!
	   				render json: current_user, status: :ok 
				else

					render json: jsonResponse, status: :bad_request
				end
	end

	def spotify_access_token
		puts(params[:access_token])
		puts("Hello")
		current_user.spotify_account_token = params[:access_token] 
		current_user.spotify_refresh = params[:refresh_token] 
		if current_user.save
			render json: current_user, status: :ok 
		else
			render status: :bad_request
		end	
	end
	def check_refresh
		response = HTTParty.get("https://api.spotify.com/v1/me", 
					{ headers: {"Authorization" => auth_header}
       					})
		if( response.code != 200)
	        	refresh_token
			return
		end
		return 
	end

	private 

	def client_id
		return Rails.application.credentials.spotify_creds[:client_id]
	end
	def client_secret
		return Rails.application.credentials.spotify_creds[:client_secret]
	end
end
