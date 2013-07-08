class AddStuffToSongs < ActiveRecord::Migration
  def change
  	  add_column :songs, :display_name, :string
  	  add_column :songs, :year, :integer
  end
end
