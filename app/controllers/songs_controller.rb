class SongsController < ApplicationController
  before_action :check_admin, except: [:guest_artist_search, :guest_song_search] #so that guests can get autocomplete data
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def guest_artist_search
	@display_names = Artist.where("name like ?", "%#{params[:term]}%")
	respond_to do |format|
		format.json {render json: @display_names.map(&:name)}
	end
  end
  
  def guest_song_search
	@artist = Artist.find_by(name: "#{params[:artist]}")
	@display_songs = @artist.songs.where("title like ?", "%#{params[:term]}%")
	respond_to do |format|
		format.json {render json: @display_songs.map(&:title)}
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
  	@merge_song = String.new
  end
  
  def update
  	if @merge_song = Song.find_by(display_name: params[:merge_song])
  		@song.votes.each do |vote|
  			vote.song_id = @merge_song.id
  			vote.save
  		end
  		@artist = @song.artists.first
  		@artist.destroy if @artist.songs.count == 1
		@song.destroy
		respond_to do |format|
			format.html { redirect_to songs_url }
			format.json { head :no_content }
		end
  	else
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
  end
  
  def destroy
	@song.votes.destroy_all
	@song.artists.each do |artist|
		artist.destroy if artist.songs.count == 1
	end
    @song.destroy
    respond_to do |format|
    	format.html { redirect_to :back }
    	format.json { head :no_content }
    end
  end
  
  def import
  	Song.import(params[:file])
  	redirect_to songs_url, notice: "Imported successfully"
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