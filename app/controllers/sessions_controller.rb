class SessionsController < Devise::SessionsController

	def new
		@guest = User.new
	end
	
end