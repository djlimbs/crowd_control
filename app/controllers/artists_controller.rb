class ArtistsController < ApplicationController
  before_action :check_admin
  before_action :set_artist, only: [:show, :edit, :destroy]

  def index
  	@artists = Artist.all
  end
  
  def new
  	@artist = Artist.new
  end

  def create
  	@artist = Artist.new(artist_params)
  	
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

  def destroy
    @artist.alt_names.each do |alt_name|
    	alt_name.destroy
    end
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end

  private
  	def set_artist
  		@artist = Artist.find(params[:id])
  	end
  	
  	def artist_params
  		params.require(:artist).permit(:name, :alt_name => [:alt_name])
  	end
end
