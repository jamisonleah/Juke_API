class CreatePartyQueues < ActiveRecord::Migration[6.0]
  def up
    create_table :party_queues do |t|
	t.string  :name
      	t.integer :party_head_id
      	t.timestamps
    end
	add_index(:party_queues, ["party_head_id"])
  end

  def down
	drop_table(:party_queues)
  end

end
