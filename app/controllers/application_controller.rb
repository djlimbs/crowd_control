class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(user)
  	if user.dj?
  		djs_path
  	else
  		couples_path
  	end
  end
  
  private
	def check_admin
		authenticate_user!
		redirect_to new_user_session_path unless current_user and current_user.is_admin?
	end
end
