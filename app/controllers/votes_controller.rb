class VotesController < ApplicationController
  include ActiveModel::Validations
 
  before_action :set_vote, only: [:destroy]

  def new
  	respond_to do |format|
  		format.js
    end
  end

  def create
  	@chart = Chart.find(params[:chart_id]) #get chart this vote is for
  	@voter_name = params[:voter_name] #get voter name
    	
  	@display_name = params[:display_name] #votes by links are entered via display name
  	@display_name = params[:name] + " - " + params[:title] if @display_name.nil? #votes by typing are entered by artist and song title fields
  	
  	@name = params[:name]
  	if @name.nil?
  		if / - / =~ @display_name #check if artist name was even entered, if not, leave @name blank.
  			@name = @display_name.split(" - ").first
  		else
  			@name = ""
  		end
  	end
  	
  	@title = params[:title]
  	@title = @display_name.split(" - ").last if @title.nil?
  	
  	@song = Song.find_or_create_song(@name, @title) #find or create the song vote is for
  	
  	if params[:commit] == "Pretty please?!"
  		@score = 1
  	elsif params[:commit] == "Play this!"
  		@score = 2
  	elsif params[:commit] == "CLEARED"
  		@score = -1.5
  	elsif params[:commit] == "Tame"
  		@score = -1
  	elsif params[:commit] == "Solid"
  		@score = 0
  	elsif params[:commit] == "Picked up!"
  		@score = 1
  	elsif params[:commit] == "RAGE"
  		@score = 1.5
  	elsif params[:commit] == "Do not play!"
  		@score = -100
  	else
  		@score = params[:score]
  	end
  	
  	@vote = Vote.new(chart_id: @chart.id, score: @score, voter_name: @voter_name, song_id: @song.id) #add vote
    	
  	respond_to do |format|
  	  if @vote.save
    		if @chart.chart_songs[@song.id].nil?
    			@new_song = true
    			@chart.chart_songs[@song.id] = 0
    			@chart.save
    		end

        @display = {}
        if @score == "-100" or @chart.chart_songs[@song.id] == "Do not play!"
        	@display[@song.id] = @score
        else
        	@display[@song.id] = @chart.chart_songs[@song.id] + @score.to_f
        end
    		format.js { }
  	  else
        @vote_failed = true
        format.js { }
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
  	    if @chart.chart_songs[@song.id] == "Do not play!"
  	    	@display[@song.id] = nil
  	    else
  	    	@display[@song.id] = @chart.chart_songs[@song.id]
  	    end
  		  format.js
  	  else
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
