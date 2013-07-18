# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  display_name :string(255)
#  year         :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Song < ActiveRecord::Base
	has_and_belongs_to_many :artists
	has_many :alt_names, :as => :diff_nameable
	has_many :votes
	
	accepts_nested_attributes_for :artists, :alt_names, allow_destroy: true
	validates_uniqueness_of :display_name
	
	def add_artists_to_song(new_artists) #accepts an array of hashes containing key, artist and adds it to the current song
  	  	new_artists.each do |key, artist|
			if artist[:_destroy] == 'false'
				self.artists.push(Artist.find_or_create_artist(artist[:name]))
			end
		end
	end
	
	def score(chart_id)
		@votes = self.votes.where(chart_id: chart_id)
		
		@score = 0
		@votes.each do |vote| 
			if vote.score == -100
				@score += -1
			else
				@score += vote.score
			end
		end
		return @score
	end
	
	def score
		@score = 0
		self.votes.each do |vote| 
			if vote.score == -100
				@score += -1
			else
				@score += vote.score
			end
		end
		return @score
	end
	
	def artist_names #returns an array of all artists that are part of this song
		return song.artists.collect{|artist| artist.name }
	end
	
	def self.find_or_create_song(request)
		if / - / =~ request
			@request = request.strip.split(' - ')
		elsif /- / =~ request
			@request = request.strip.split('- ')
		end
		@request_name = @request.first.strip
		@request_title = @request.last.strip
		@display_name = String.new(@request_name + ' - ' + @request_title)
		
		@song = Song.find_by(display_name: @display_name)
		
		if @song.nil?
			@artist = Artist.find_or_create_artist(@request_name)
			@song = @artist.songs.where('lower(title) = ?', @request_title.downcase).first
		end
		
		if @song.nil?
			@song = Song.new(title: @request_title)
			@song.artist_ids = @artist.id
			@song.display_name = @display_name
			@song.save
		end
		
		return @song
	end
end
