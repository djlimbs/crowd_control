class StaticPagesController < ApplicationController
	before_action :check_user, except: [:get_chart]
	
  	def home
  	end

  	def djs
  		@dj = current_user
  		@couples = @dj.couples.all
  		@chart = Chart.find_by(name: @couples.first.name)
  		@display = @chart.gather_votes
  	end

	def couples
		@chart = Chart.find_by(name: current_user.name)
		@display = @chart.gather_votes
		@voter_name = current_user.name
	end

	def get_chart
		@chart = Chart.find_by(name: params[:name])
 		@display = @chart.gather_votes
 		@voter_name = params[:voter_name]
 		
 		respond_to do |format|
 			format.html
 			format.json
 			format.js
 		end
 	end

  	def guests
  	  	@temp_user = User.new(guest_params)
  	  	@voter_name = @temp_user.name
  		@couple = User.find(@temp_user.id)
  		@dj = User.find(@couple.dj_id)
  	  	@chart = Chart.find_by(name: @couple.name)
  	  	@display = @chart.gather_votes
  	  	if guest_params[:password] != @chart.password
  			redirect_to new_user_session_path, notice: 'Incorrect couple password'
  		end
  		
  		@guest_vote = String.new
  	end
  	
  	private
  		def check_user
  			if current_user
  				if current_user.is_admin?
  					redirect_to users_path
  				end
  			
				if current_user.dj? and action_name != 'djs' 
					redirect_to djs_path
				end
			
				if current_user.couple? and action_name != 'couples' 
					redirect_to couples_path
				end
  			elsif action_name != 'guests'
  				redirect_to new_user_session_path
  			end
  		end
  		
  		def guest_params
  			params.require(:user).permit(:id, :name, :password)
  		end
end
