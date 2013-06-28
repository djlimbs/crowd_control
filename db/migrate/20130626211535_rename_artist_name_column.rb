class RenameArtistNameColumn < ActiveRecord::Migration
  def self.up
  	rename_column :artists, :artist_name, :name
  end
  
  def self.down
  	rename_column :artists, :name, :artist_name
  end
end
