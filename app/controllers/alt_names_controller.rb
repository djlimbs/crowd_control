class AltNamesController < ApplicationController
  before_action :set_alt_name, only: [:show, :edit]

  def index
  	@alt_names = AltName.all
  end
  
  def new
  	@alt_name = AltName.new
  end

  def create
    @alt_name = AltName.new(alt_name_params)

    respond_to do |format|
      if @alt_name.save
        format.html { redirect_to @alt_name, notice: 'AltName was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alt_name }
      else
        format.html { render action: 'new' }
        format.json { render json: @alt_name.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
  	@alt_name = AltName.find(params[:id])
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
