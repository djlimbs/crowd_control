class ArtistSong < ActiveRecord::Base
	belongs_to :artist
	belongs_to :song
	has_many :votes
end
