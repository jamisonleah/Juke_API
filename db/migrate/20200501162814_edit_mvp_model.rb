class EditMvpModel < ActiveRecord::Migration[6.0]
  def up
	
	#change relation through guestlist
  	remove_index :songs, :party_queue_id
	remove_column :songs, :party_queue_id

	# add songs to the guestlist
	add_column :guestlists, :song_id, :integer 
	add_index  :guestlists, :song_id

	# add where the songs will be 
	add_column :guestlists, :priority, :integer 
	add_column :guestlists, :pending_status, :boolean

  end

  def down 

	#change relation through guestlist
	add_column :songs, :party_queue_id, :integer 
  	add_index :songs, :party_queue_id

	# add songs to the guestlist
	remove_index  :guestlists, :song_id
	remove_column :guestlists, :song_id, :integer 

	# add where the songs will be 
	remove_column :guestlists, :priority, :integer 
	remove_column :guestlists, :pending_status, :boolean
  end
end
