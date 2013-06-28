class Song < ActiveRecord::Base
	has_many :artist_songs
	has_many :artists, :through => :artist_songs
	has_many :alt_names, :as => :diff_nameable

	accepts_nested_attributes_for :artists, :alt_names
end