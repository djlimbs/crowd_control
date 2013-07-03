class StaticPagesController < ApplicationController
	before_filter :check_user
	
  	def home
  	end

  	def djs
  		@dj = current_user
  	end

  	def guests
  	  	@password = String.new(guest_params[:password])
  		if @password != 'hophippo'
  			redirect_to new_user_session_path, notice: 'Incorrect couple password'
  		end
  	
  		@guest_name = String.new(guest_params[:name])
  		@guest_id = guest_params[:id]
  		@couple = User.find(@guest_id)
  		@dj = User.find(@couple.dj_id)
  	end

  	def couples
  	end
  	
  	private
  		def check_user
  			if current_user
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
