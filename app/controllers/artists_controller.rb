class ArtistsController < ApplicationController
  before_action :check_admin
  before_action :set_artist, only: [:show, :edit, :destroy, :update]

  def index
  	@artists = Artist.where("name like ?", "%#{params[:term]}%")
  	respond_to do |format|
  		format.html
  		format.json {render json: @artists.map(&:name) }
  	end
  end
  
  def new
  	@artist = Artist.new
  end

  def create
  	@artist = Artist.new(artist_params)
  	@artist.songs.build(title: "Anything by " + artist_params[:name], display_name: "Anything by " + artist_params[:name])
  	respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @artist }
      else
        format.html { render action: 'new' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  end

  def edit
  end

  def update
	respond_to do |format|
      if @artist.update_attributes(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @artist }
      else
        format.html { render action: 'new' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @artist.alt_names.destroy_all
    @artist.songs.each do |song|
    	song.destroy unless song.artists.count > 1
    end
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end

  def import
  	Artist.import(params[:file])
  	redirect_to artists_url, notice: "Imported successfully"
  end

  private
  	def set_artist
  		@artist = Artist.find(params[:id])
  	end
  	
  	def artist_params
  		params.require(:artist).permit(:name, :alt_names_attributes => [:alt_name, :_destroy, :id])
  	end
end
