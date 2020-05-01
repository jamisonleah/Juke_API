class ChangePartyId < ActiveRecord::Migration[6.0]
  def up
  	rename_column :party_queues, :party_head_id, :user_id
  end

  def down 
	rename_column :party_queues, :user_id, :party_head_id
  end
end
