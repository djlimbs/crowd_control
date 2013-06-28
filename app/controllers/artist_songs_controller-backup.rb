class ArtistSongsController < ApplicationController
  before_action :set_artist_song, only: [:show, :edit, :destroy]

  def index
  end

  def new
  	@artist = Artist.new
  	@artist_song = @artist.artist_songs.build
  	@song = @artist.songs.build
  end

  def create
  	@artist = Artist.new(artist_params)
  	@song = @artist.songs.build(song_params)
  	@artist_song = ArtistSong.new(artist_song_params)
  	
  	respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist_song, notice: 'Artist song was successfully created.' }
        format.json { render action: 'show', status: :created, location: @artist_song }
      else
        format.html { render action: 'new' }
        format.json { render json: @artist_song.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  end

  def edit
  end
  
  def destroy
  end
  
  private
  	def set_artist_song
  		@artist_song = ArtistSong.find(params[:id])
  		@artist = Artist.find(@artist_song.artist_id)
  		@song = @artist.songs.first
  	end
  	
  	def artist_song_params
  		params.require(:artist_song).permit(:id)
  	end
  	
  	def artist_params
  		params.require(:artist).permit(:name)
  	end
  	
  	def song_params
  		params.require(:song).permit(:title)
  	end
  	
  	def alt_name_params
  		params.require(:alt_name).permit(:alt_name, :diff_nameable_type, :diff_nameable_id)
  	end
end
