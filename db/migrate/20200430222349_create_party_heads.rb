class CreatePartyHeads < ActiveRecord::Migration[6.0]
  def up
    create_table :party_heads do |t|
      t.integer :user_id      
      t.timestamps
    end
    add_index(:party_heads, ["user_id"])
  end

  def down 
	drop_table :party_heads
  end

end
