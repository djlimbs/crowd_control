class ArtistsController < ApplicationController
  before_action :check_admin
  before_action :set_artist, only: [:show, :edit, :destroy]

  def index
  	@artists = Artist.all
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
end
