class RemoveYearFromSong < ActiveRecord::Migration
  def change
    remove_column :songs, :year, :integer
  end
end
