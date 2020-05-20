class PartyQueue < ApplicationRecord
	belongs_to :host, class_name: :User, optional: false, foreign_key: "user_id"
	has_many :SongRequests
	has_many :Guestlists
        has_many :partygoers, class_name: :User, :through => :Guestlist, foreign_key: "user_id"

end
