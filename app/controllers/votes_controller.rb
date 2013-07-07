class VotesController < ApplicationController
  def new
  	@chart = Chart.find(params[:chart_id])
  	@vote = String.new
  	@voter_name = params[:voter_name]
  	
	respond_to do |format|
		format.html
		format.json { render json: @vote }
		format.js
	end
  end

  def create
	@chart = Chart.find(params[:chart_id])
	@voter_name = params[:voter_name]
	  	
  	@request = params[:string].strip.split(' - ')
  	@name = @request.first.strip
  	@title = @request.last.strip
  	
  	@display_name = @name + ' - ' + @title
  	
  	if !exact_match && !found_by_alt_names
  		create_song
  	end
  	
  	@vote = Vote.new
    @vote.chart_id = @chart.id
  	@vote.score = 1
  	@vote.voter_name = @voter_name  	
  	@vote.artist_song_id = @artist_song.id
  	
	respond_to do |format|
	  if @vote.save
		format.html { redirect_to guests_path, notice: 'Vote was successfully created.' }
		format.json { head :no_content }
		format.js
	  else
		format.html { redirect_to guests_path, notice: 'didnt work' }
		format.json { render json: @vote.errors, status: :unprocessable_entity }
	  end
  	end

  end
  
  private
  	def chart_params
  		params.require(:chart_id)
  	end
  	
  	def exact_match
  		@artist_song = ArtistSong.where('lower(display_name) = ?', @display_name.downcase).first
  	end
  	
  	def found_by_alt_names
  		@possible_artist = Artist.where('lower(name) = ?', @name.downcase).first
  		if @possible_artist.nil?
  			@possible_alt_name = AltName.where(diff_nameable_type: 'Artist').where('lower(alt_name) = ?', @name.downcase).first
  			if @possible_alt_name.nil?
  				return false
  			else
  				@possible_artist = Artist.find_by(id: @possible_alt_name.diff_nameable_id)
  			end
  		end
  		
		@possible_song = @possible_artist.songs.where('lower(title) = ?', @title.downcase).first
		if @possible_song.nil?
			@possible_alt_title = AltName.where(diff_nameable_type: 'Song').where('lower(alt_name) = ?', @title.downcase).first
			if @possible_alt_title.nil?
				return false
			else
				@possible_song = Song.find_by(id: @possible_alt_title.diff_nameable_id)
			end
		end 			
  		
  		if @possible_song.nil?
  			return false
  		else
  			@artist_song = ArtistSong.find_by(artist_id: @possible_artist.id, song_id: @possible_song.id)
  			return true
  		end
  	end
  	
  	def create_song
  		@new_song = Song.create(:title => @title)
  		@artist = Artist.new(:name => @name)
  		@artist_song = @new_song.artist_songs.new(:artist => @artist)
  		@artist_song.display_name = @name + " - " + @title
  		@artist_song.save
  	end
end
