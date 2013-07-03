class ArtistSongsController < ApplicationController
  before_action :check_admin
  before_action :set_artist_song, only: [:show, :edit, :destroy]

  def index
  	@artist_songs = ArtistSong.all
  end

  def new
  end

  def create
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
  	end
end
