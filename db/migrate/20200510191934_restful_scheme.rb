class RestfulScheme < ActiveRecord::Migration[6.0]
  def up
  	drop_table :songs
	remove_index :guestlists, :song_id
	rename_column :guestlists, :song_id, :spotify_id
	rename_table :guestlists, :songRequests
       		
  
  end

  def down 
  	create_table :songs
	rename_table :songRequests, :guestlists
	rename_column :guestlists, :spotify_id, :song_id
	add_index :guestlists, :song_id
  end

end
