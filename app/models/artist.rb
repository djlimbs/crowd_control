class Artist < ActiveRecord::Base
	has_many :artist_songs
	has_many :songs, :through => :artist_songs
	has_many :alt_names, :as => :diff_nameable

	accepts_nested_attributes_for :songs, :alt_names
end
