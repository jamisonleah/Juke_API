class CreatePartyGoers < ActiveRecord::Migration[6.0]
  def change
    create_table :party_goers do |t|
      t.integer :user_id
      t.timestamps
    end
    add_index(:party_goers, ["user_id"])
  end

  def down 
	drop_table :party_goers
  end

end
