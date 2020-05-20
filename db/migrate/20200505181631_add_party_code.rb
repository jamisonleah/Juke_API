class AddPartyCode < ActiveRecord::Migration[6.0]
  def up
  	add_column :party_queues, :party_code, :string, uniqueness: true
  end

  def down 
	remove_column :party_queues, :party_code, :string
  end

end
