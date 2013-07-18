class VotesController < ApplicationController
  include ActiveModel::Validations
 
  before_action :set_vote, only: [:destroy]
  before_action :check_display_name, only: [:create]

  def new
  	@chart = Chart.find(params[:chart_id])
  	@display_name = String.new
  	@voter_name = params[:voter_name]
	respond_to do |format|
		format.html
		format.json { render json: @vote }
		format.js
	end
  end

  def create
	@chart = Chart.find(params[:chart_id]) #get chart this vote is for
	@voter_name = params[:voter_name] #get voter name
  	
  	@song = Song.find_or_create_song(params[:display_name]) #find or create the song vote is for
  	
  	if params[:commit] == "Pretty please?!"
  		@score = 1
  	elsif params[:commit] == "CLEARED"
  		@score = -1
  	elsif params[:commit] == "Tame"
  		@score = -0.5
  	elsif params[:commit] == "Solid"
  		@score = 0
  	elsif params[:commit] == "Picked up!"
  		@score = 0.5
  	elsif params[:commit] == "RAGE"
  		@score = 1
  	end
  	
  	@vote = Vote.new(chart_id: @chart.id, score: @score, voter_name: @voter_name, song_id: @song.id) #add vote
  	
	respond_to do |format|
	  if @vote.save
		if @chart.chart_songs[@song.id].nil?
			@new_song = true
			@chart.chart_songs[@song.id] = @vote.score
			@chart.save
		end
	    @display = {}
	    @display[@song.id] = params[:score]
		format.html { redirect_to guests_path, notice: 'Vote was successfully created.' }
		format.json { head :no_content }
		format.js { }
	  else
		format.html { redirect_to guests_path, notice: 'didnt work' }
		format.json { render json: @vote.errors, status: :unprocessable_entity }
	  end
  	end
  end
  
  def destroy
  	@chart = Chart.find(@vote.chart_id)
	@voter_name = @vote.voter_name
	@song = Song.find(@vote.song_id)
	respond_to do |format|
	  if @vote.destroy
	    @display = Hash.new()
	    @display[@song.id] = nil
		format.html { redirect_to guests_path, notice: 'Vote was deleted.' }
		format.js
	  else
		format.html { redirect_to guests_path, notice: 'didnt work' }
		format.json { render json: @vote.errors, status: :unprocessable_entity }
	  end
  	end
  end
  
  private
    def check_display_name
    	redirect_to :back, :notice => 'Please enter the song in Artist - Song format' unless / - / =~ params[:display_name]
    end
  
  	def chart_params
  		params.require(:chart_id)
  	end
  	
  	def set_vote
  		@vote = Vote.find(params[:id])
  	end
end
