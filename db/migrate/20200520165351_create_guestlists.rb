class CreateGuestlists < ActiveRecord::Migration[6.0]
  def up
    create_table :guestlists do |t|
      	t.integer :user_id
	t.integer :party_queue_id
      	t.timestamps
    end
	add_index(:guestlists, ["user_id"])
	add_index(:guestlists, ["party_queue_id"])
  end
  def down 
	drop_table :guestlists

  end
end
