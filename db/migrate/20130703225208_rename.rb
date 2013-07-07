class Rename < ActiveRecord::Migration
  def self.up
  	rename_column :votes, :chart_song_id, :chart_id
  end
  
  def self.down
  	rename_column :votes, :chart_id, :chart_song_id
  end
end
