class UserController < ApplicationController
	def spotify
		    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

		if(params[:hello] == "Bitch I got it out the muscle")
			render :json => {"reply": "You wanna fight I wanna Tussle"}
		else
			puts("What bro?")
		end
	end
end
