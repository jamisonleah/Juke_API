class AddSpotifyBase < ActiveRecord::Migration[6.0]
  def up
	add_column :users, :spotify_account_token, :text
  end
  def down 
	remove_column :users, :spotify_account_token, :text
  end

end
