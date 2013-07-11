class SongsController < ApplicationController
  before_action :check_admin, except: [:guest_search] #so that guests can get autocomplete data
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def guest_search
	@display_names = Song.where("display_name like ?", "%#{params[:term]}%")
	respond_to do |format|
		format.json {render json: @display_names.map(&:display_name)}
	end
  end
  
  def index
  	@songs = Song.all
  	@display_names = Song.where("display_name like ?", "%#{params[:term]}%")
  	respond_to do |format|
  		format.html
  		format.json {render json: @display_names.map(&:display_name)}
  	end
  end

  def new
  	@song = Song.new
  	@song.artists.new
  end

  def create
  	@song = Song.new(song_params)
  	@song.add_artists_to_song(artist_params[:artists_attributes])
	
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
  end

  def edit
  end
  
  def update
	@song.artists.clear
	@song.add_artists_to_song(artist_params[:artists_attributes])
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
	@song.votes.destroy_all
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
  		params.require(:song).permit(:id, :display_name, :title, :alt_names_attributes => [:id, :alt_name, :_destroy])
  	end
  	
  	def artist_params
  		params.require(:song).permit(:artists_attributes=> [:id, :name, :_destroy])
  	end
  	
  	def artist_song_params
  		params.require(:song).permit(:id, :display_name, :title, :alt_names_attributes => [:id, :alt_name, :_destroy], :artists_attributes=> [:id, :name, :_destroy])
  	end
end