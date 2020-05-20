class PartyQueueController < ApplicationController
	before_action :authenticate_user!
	require 'json'
	require 'ostruct'
	require 'securerandom'


def index 
	render json: PartyQueue.all, status: :ok
       		
end
#all the 'GET' request methods 
def create 
	# else just make the queue 
	user = User.find(current_user.id)
	partycode = party_code + "_" + params[:name] + "_" + party_code 
	party = PartyQueue.new(:host => user, :name => params[:name], :party_code => partycode )
	
	if party.save!
		render json: party, status: :ok
		return 
	else
		render status: :bad_request 
		return 
	end
end
def delete 
	partyQueue = PartyQueue.find(params[:party_queue_id]) 
	partyQueue.destroy
end

#params party_queue_id (either in url or post) 
def update
	
	# type: REQUEST, JOIN, PARTY_CODE, IMAGES
	error = []
	type = params[:type] 
	partyQueue = PartyQueue.find_by(params[:party_code]) 
	
	if !type
		error <<  {type: "Type cannot be blank"}
	end

	if partyQueue 
		case(type) 
		when "REQUEST"
			newRequest = SongRequest.new 
			newRequest.spotify_id = params[:spotify_id] 
			newRequest.partyQueue = partyQueue
			newRequest.pending_status = true 
			newRequest.partygoers = current_user
			render :json => newRequest
			return 
		when "JOIN"
			newGuest = Guestlist.new
			newGuest.partyQueue = partyQueue
			newGuest.partygoers = current_user
			#if newGuest.save!
			render :json => newGuest
			return 
		end
	end

end
def suggest
	partyQueue = PartyQueue.find_by(params[:party_code]) 
end

def pending(party)  
	return SongRequest.find_by(:pending_status => true, :party_queue_id => party.id) 
end
def accepted(party)
	return SongRequest.find_by(:pending_status => false, :party_queue_id => party.id) 
end
def guestList(party)
	return Guestlist.all
end
def show
	party = PartyQueue.find_by(:party_code => params[:party_code])
	if party
		acceptedSongs = SongRequest.find_by(:pending_status => false, :party_queue_id => party.id) 
	else
		render :json => "No such party" 
		return
	end
	render :json => acceptedSongs
end

#Here are some 'POST' request 


def partyqueue_params
	params.require(:party_queue).permit(:name)
end

def party_code
	code = SecureRandom.alphanumeric
	split_code = code.split('')
	numb = ""

	for i in 0..3
		numb += split_code[i] 	
	end
	return numb
end

end
