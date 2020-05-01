class CreateSongs < ActiveRecord::Migration[6.0]
  def up
    create_table :songs do |t|
      t.text :spotify_id	
      t.integer :party_queue_id
      t.timestamps
    end
	add_index(:songs, ["party_queue_id"])
  end

  def down 
	drop_table :songs

  end
end
