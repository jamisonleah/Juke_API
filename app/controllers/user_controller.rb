class UserController < ApplicationController
	before_action :authenticate_user!

	def spotify
		if current_user.spotify_account_token
			render json: true
			return
		else
			render json: false 
			return 
		end
	end
	def home 
		render json: current_user
	end
	def info
		render json: "You can enter this data"
	end
	def partys
		party = PartyHead.find_by(:user_id => current_user.id) 
		render json: party
	end

end
