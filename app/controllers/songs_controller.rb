class SongsController < ApplicationController
  before_action :check_admin
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
  	@songs = Song.all
  end

  def new
  	@song = Song.new
  	@song.artists.new
  end

  def create
  	@song = Song.new(song_params)
  	artist_params[:artists_attributes].each do |key, artist|
  		if @artist = Artist.find_by(:name => artist[:name])
  			@song.artists.push(@artist)
		elsif @alt_name = AltName.find_by(:alt_name => artist[:name])
			@song.artists.push(Artist.find_by(id: @alt_name.diff_nameable_id))
		else
			@song.artists.new(artist)
		end
	end
	
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
  	@song = Song.find_by(id: @song.id)
  end

  def edit
  end
  
  def update
	respond_to do |format|
	  if @song.update_attributes(song_params)
		format.html { redirect_to songs_path, notice: 'Song was successfully updated.' }
		format.json { head :no_content }
	  else
		format.html { render action: 'edit', notice: 'didnt work' }
		format.json { render json: @song.errors, status: :unprocessable_entity }
	  end
	end
  end
  
  
  def destroy
    @song.destroy
    respond_to do |format|
    	format.html { redirect_to songs_url }
    	format.json { head :no_content }
    end
  end
  
  private
  	def set_song
  		@song = Song.find(params[:id])
  	end
  	
  	def song_params
  		params.require(:song).permit(:id, :display_name, :title, :alt_names_attributes => [:id, :alt_name])
  	end
  	
  	def artist_params
  		params.require(:song).permit(:artists_attributes=> [:id, :name, :alt_names_attributes => [:id, :alt_name]])
  	end
  	
  	 def artist_song_params
  		params.require(:song).permit(:id, :display_name, :title, :alt_names_attributes => [:id, :alt_name], :artists_attributes=> [:id, :name, :alt_names_attributes => [:id, :alt_name]])
  	end
end