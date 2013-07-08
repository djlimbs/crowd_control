class UsersController < ApplicationController
	include Devise::Controllers::Helpers
	before_action :check_admin
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	
	def index
		@users = User.all
	end
	
	def edit
		@chart = Chart.find_by(name: @user.name)
		@djs = User.find(:all, :conditions => ['dj_id IS ?', nil])
	end
	
	def new
		@chart = Chart.new
		@user = User.new
		@djs = User.find(:all, :conditions => ['dj_id IS ?', nil])
	end

	def create
		@user = User.new(user_params)
		@chart = Chart.new
		@chart.user_id = @user.dj_id
		@chart.name = @user.name
		@chart.password = params[:chart][:password]
		@chart.save
		respond_to do |format|
		  if @user.save
			format.html { redirect_to users_url, notice: 'User was successfully created.' }
			format.json { head :no_content }
		  else
			format.html { redirect_to users_url, notice: 'didnt work' }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end
	
	def update
		params[:user].delete(:password) if params[:user][:password].blank?
		params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
		respond_to do |format|
		  if @user.update_attributes(user_params)
		  	@chart = Chart.find_by(name: @user.name)
		  	@chart.password = params[:chart][:password]
		  	@chart.save
			format.html { redirect_to users_path, notice: 'User was successfully updated.' }
			format.json { head :no_content }
		  else
			format.html { render action: 'edit', notice: 'didnt work' }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end
	
	def destroy
		@user.destroy
		respond_to do |format|
		  format.html { redirect_to users_url }
		  format.json { head :no_content }
		end
	end
	
	private
		def set_user
			@user = User.find(params[:id])
		end
		
		def user_params
      		params.require(:user).permit(:name, :email, :password, :password_confirmation, :dj_id)
    	end
end