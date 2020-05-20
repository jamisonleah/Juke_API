class SongRequest < ApplicationRecord
	
	belongs_to :partygoers, class_name: :User, optional: false, foreign_key: "user_id"
	belongs_to :partyQueue, foreign_key: "party_queue_id"



end
