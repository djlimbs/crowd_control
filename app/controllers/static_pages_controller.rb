class StaticPagesController < ApplicationController
	before_filter :check_user
	
  	def home
  	end

  	def djs
  		@dj = current_user
  	end

  	def guests
  		@vote = Vote.new
  	
  	  	@temp_user = User.new(guest_params)
  	  	@guest_name = @temp_user.name
  		@couple = User.find(@temp_user.id)
  		@dj = User.find(@couple.dj_id)
  	  	@chart = Chart.find_by(name: @couple.name)
  	  	
  	  	if guest_params[:password] != @chart.password
  			redirect_to new_user_session_path, notice: 'Incorrect couple password'
  		end
  		
  		@guest_vote = String.new
  		

  	end

  	def couples
  		@couple = current_user
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
