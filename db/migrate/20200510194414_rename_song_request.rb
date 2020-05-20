class RenameSongRequest < ActiveRecord::Migration[6.0]
  def up
  	rename_table :songRequests, :song_requests
  end

  def down 
  	rename_table :song_requests, :songRequests
  end
end
