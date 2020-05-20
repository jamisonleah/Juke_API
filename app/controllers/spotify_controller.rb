class SpotifyController < ApplicationController
	require 'httparty'
	require 'base64'
	require 'json'

	before_action :authenticate_user!
	before_action :check_refresh
	##
	# refresh_token refreshes a current_users token for spotify 
	# when that token can no longer be used 
	# when completed it returns the current_user as a JSON object 
	# if an issue occuers it will render a bad_request 
	def me
	    # wanted it to be easy to view 
	    response = HTTParty.get("https://api.spotify.com/v1/me", 
				    { headers: { "Authorization" => auth_header }
	    			    })
	    render json: response, status: :ok 

	end
	def tracks
		
	    user_track_path = "https://api.spotify.com/v1/me/tracks"
	    response = HTTParty.get( user_track_path, 
				{ headers: { "Authorization" => auth_header }
	    			})    
	    render json: response, status: :ok
	end


	#current song playing -> to be used 
	def current 
		response = HTTParty.put("https://api.spotify.com/v1/me/player/play", 
					{ headers: {"Authorization" => auth_header}
       					})

		render json: response, status: :ok

	end

	##
	# albumSearch 
	# 
	# returns all the tracks in a given album 
	def albumSearch
	    response = getMethod("https://api.spotify.com/v1/albums/#{params[:album_id]}/tracks")
	    case response.code
	    when 200
	    	render json: response, status: :ok
	    else
		render status: :bad_request
	    end
	end

	def searchCenter 
		search = params[:search_text] 
		type = "album,track,artist"

		response = HTTParty.get("https://api.spotify.com/v1/search/?q=#{search}&type=#{type}",
					{ headers: {"Authorization" => auth_header}
       					})
		#another way to parse it  but...
	   	#jsonResponse = JSON.parse(response.body, symbolize_names: true) #=> {key: :value}
		albums = response.parsed_response["albums"]["items"]
		artists = response.parsed_response["artists"]["items"]
		tracks = response.parsed_response["tracks"]["items"]
		
		# lets parse tracks first!
		track_info = []
		tracks.each do |item|
			my_hash = 
			{
				:id         => item["id"],
				:name       => item["name"],
				:explicit   => item["explicit"],
				:popularity => item["popularity"],
				:artists    => item["artists"],
				:album      => simpAlbum(item["album"])


			}
			track_info << my_hash 	
		end
		album_info = []
		albums.each do | item |
			my_hash = 
			{
				:id 	 => item["id"], 
				:name 	 => item["name"], 
				:images  => item["images"], 
				:artists => item["artists"],
			}
			album_info << my_hash
		end

		artists_info = []
		artists.each do | item |
			my_hash = 
			{
				:id	     => item["id"], 
				:name 	     => item["name"],
				:popularity  => item["popularity"], 
				:genres      => item["genres"], 
				:images      => item["images"]
			}
			artists_info << my_hash
		end
	
		master_object = 
		{ 	
			:tracks  =>  track_info, 
			:albums  =>  album_info, 
			:artists => artists_info

	
		}
		render json: master_object, status: :ok


	end

	private
	#auth_header comes from application controller. Probably should be in spotify controller 
	
	##
	# getMethod 
	#
	# endpoint : Url of where you want to make your request 
	# return : response 
	def getMethod(endpoint) 
		response = HTTParty.get(endpoint, 
					{ headers: {"Authorization" => auth_header}
       					})
		return response 
	end
	
	##
	# PutMethod 
	#
	# endpoint -> URL of where you want to make your request to 
	# return : response 
	def putMethod(endpoint) 
		response = HTTParty.put(endpoint, 
					{ headers: {"Authorization" => auth_header}
       					})
		return response 
	end

	##
	# postMethod
	# endpoint -> the URL where youre trying to get your request from 
	# headers -> necassary headers for request
	# body -> body of Request 
	#
	#
	# return : response 
	def postMethod(endpoint,headers,body) 
		response = HTTParty.post(endpoint, :headers => headers,:body => body)
		return response 
	end


	def sortByPopularity(sortedList, obejct) 
	# albums don't have popularity, so we will sort by artists 
	
	end


	def simpAlbum(album)
		
		album_info = []
			my_hash = 
			{
				:id	     => album["id"], 
				:name 	     => album["name"], 
				:images      => album["images"],
				:artists     => album["artists"]
			}
			album_info << my_hash
		return album_info
	
	end

end
