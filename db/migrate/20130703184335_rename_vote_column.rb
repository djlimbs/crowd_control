class RenameVoteColumn < ActiveRecord::Migration
  def self.up
  	rename_column :votes, :song_id, :artist_song_id
  end
  
  def self.down
  	rename_column :votes, :artist_song_id, :song_id
  end
end
