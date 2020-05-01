class AddRefreshToken < ActiveRecord::Migration[6.0]
  def up
  	
	add_column :users, :spotify_refresh, :text
  
  end

  def down 
	remove_column :users, :spotify_refresh, :text
  end
end
