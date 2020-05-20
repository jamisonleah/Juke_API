class RemodelMvp < ActiveRecord::Migration[6.0]
  def up
  	#remove partyhead and partygoer tables
	drop_table :party_heads
	drop_table :party_goers 

	#edit party_queue columns
	rename_column :party_queues, :party_head_id, :user_id 

	#edit guestlist columns 
	rename_column :guestlists, :party_goer_id, :user_id	
  
  end

  def down 

	add_table :party_heads
	add_column :party_heads, :user_id, :integer
	add_index :party_heads, :user_id
	add_table :party_goers 
	add_column :party_goers, :user_id, :integer 
	add_index :party_goers, :user_id 


	#edit party_queue columns
	rename_column :party_queues, :user_id, :party_head_id

	#edit guestlist columns 
	rename_column :guestlists, :user_id, :party_goer_id
  end
end
