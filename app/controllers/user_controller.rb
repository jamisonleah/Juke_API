class UserController < ApplicationController
	before_action :authenticate_user!

	def spotify
		spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
		render json: spotify_user
	end
	def home 
		render json: current_user
	end
	def info
		render json: "You can enter this data"
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


end
