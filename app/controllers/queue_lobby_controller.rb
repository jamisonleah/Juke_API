class QueueLobbyController < ApplicationController
	def accept 
		song = params[:song_id] 
		request = Guestlist.find_by(:song_id => song) 
		if request
			request.pending = false 
			if request.save! 
				render status: :ok
			       	return 	
			end
		end
		render status: :bad_request 	
	end


	def deny 
		song = params[:song_id] 
		request = Guestlist.find_by(:song_id => song) 
		request.destroy 
		
		render  
	end
	def priority 
		render :json => "Change queue priority" 
	end
	def requestsong 
		spotify_code = params[:spotify_code] 
		party_code = PartyQueue.find_by(:party_code => params[:party_code])
		#count = Guestlist.find_by(:party_code => party_code) 

		guest = Guestlist.new 
		
		render json: guest
		
	end




end
