# == Schema Information
#
# Table name: artist_songs
#
#  id           :integer          not null, primary key
#  artist_id    :integer
#  song_id      :integer
#  display_name :string(255)
#  year         :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ArtistSong < ActiveRecord::Base
	belongs_to :artist
	belongs_to :song
	has_many :votes
end
