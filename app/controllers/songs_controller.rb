class SongsController < ApplicationController
  before_action :check_admin
  before_action :set_song, only: [:show, :edit, :destroy]

  def index
  	@songs = Song.all
  end

  def new
  	@song = Song.new
  end

  def create
  	@song = Song.new(song_params)
  	@song_alt_names = alt_song_params[:alt_name][:alt_name].split(',')
  	@song_alt_names.each do |song_alt_name|
  		song_alt_name.rstrip
  		song_alt_name.lstrip
  		@song.alt_names.build(alt_name: song_alt_name)
  	end
  	
  	if artist_exists?
  		if @artist.nil?
  			@artist = Artist.find_by(id: @alt_artist.diff_nameable_id)
  		end
  		@artist_song = @song.artist_songs.build(artist: @artist)
  	else
  		@artist = Artist.new(artist_params[:artist])
  		@artist_song = @song.artist_songs.build(artist: @artist)
  		@artist_alt_names = alt_artist_params[:artist][:alt_name][:alt_name].split(',')
  		@artist_alt_names.each do |artist_alt_name|
  			@artist.alt_names.build(alt_name: artist_alt_name)
  		end
  	end
  	
	@artist_song.display_name = @artist.name + " - " + @song.title
	
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Artist and song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @song }
      else
        format.html { render action: 'new' }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  	@artist_song = ArtistSong.find_by(song_id: @song.id)
  end

  def edit
  end
  
  def destroy
    @song.destroy
    respond_to do |format|
    	format.html { redirect_to songs_url }
    	format.json { head :no_content }
    end
  end
  
  private
  	def artist_exists?
  		@artist = Artist.find_by(name: artist_params[:artist][:name]) or @alt_artist = AltName.find_by(alt_name: artist_params[:artist][:name])
  	end
  	
  	def set_song
  		@song = Song.find(params[:id])
  	end
  	
  	def song_params
  		params.require(:song).permit(:title)
  	end
  	
  	def artist_params
  		params.require(:song).permit(:artist => [:name])
  	end
  	
  	def alt_artist_params
  		params.require(:song).permit(:artist => [:alt_name => [:alt_name]])
  	end
  	
  	def alt_song_params
  		params.require(:song).permit(:alt_name => [:alt_name])
  	end
end