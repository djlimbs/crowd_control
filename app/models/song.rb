# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  title        :string(255)
#  display_name :string(255)
#  year         :integer
#

class Song < ActiveRecord::Base
	has_and_belongs_to_many :artists
	has_many :alt_names, :as => :diff_nameable

	accepts_nested_attributes_for :artists, :alt_names, allow_destroy: true
	
	validates_presence_of :title, :display_name, :artists
	
	def add_artists_to_song(new_artists) #accepts an array of hashes containing key, artist and adds it to the current song
  	  	new_artists.each do |key, artist|
			if artist[:_destroy] == 'false'
				self.artists.push(Artist.find_or_create_artist(artist[:name]))
			end
		end
	end
	
	def artist_names #returns an array of all artists that are part of this song
		return song.artists.collect{|artist| artist.name }
	end
	
	def self.find_or_create_song(request)
		@request = request.strip.split(' - ')
		@request_name = @request.first.strip
		@request_title = @request.last.strip
		@display_name = String.new(@request_name + ' - ' + @request_title)
		
		@artist = Artist.find_or_create_artist(@request_name)
		@song = @artist.songs.where('lower(title) = ?', @request_title.downcase).first
		
		if @song.nil?
			@song = Song.new(title: @request_title)
			@song.artists.build(name: @artist.name)
			@song.display_name = @display_name
			@song.save
		end
		
		return @song
	end
end
