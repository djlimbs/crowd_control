class ChartsController < ApplicationController
  before_action :check_admin
  before_action :set_chart, only: [:show, :edit, :destroy, :update]

  def index
  	@charts = Chart.all
  end
 
  def new
  end
  
  def show
  	@chart.gather_votes
  	@display = @chart.chart_songs
  	@owner = User.where(id: @chart.user_id).first
  end

  def edit
  end
  
  def destroy
    @chart.destroy
    respond_to do |format|
      format.html { redirect_to charts_url }
      format.json { head :no_content }
    end
  end
  
  def update
  end
  
  private
  	def set_chart
  		@chart = Chart.find(params[:id])
  	end
end
