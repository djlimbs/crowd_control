class AltNamesController < ApplicationController
  before_action :set_alt_name, only: [:show, :edit, :destroy]

  def index
  	@alt_names = AltName.all
  end
  
  def new
  end

  def create
  end
  
  def show
  end

  def destroy
	@alt_name.destroy
	respond_to do |format|
    	format.html { redirect_to alt_names_url }
    	format.json { head :no_content }
    end
  end
  
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alt_name
      @alt_name = AltName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alt_name_params
      params.require(:alt_name).permit(:alt_name, :diff_nameable_type, :diff_nameable_id)
    end
end
