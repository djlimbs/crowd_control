class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters, :only => [:create, :update]
  before_filter :find_djs, :only => [:new]
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :dj_id) }
      devise_parameter_sanitizer.for(:account_update) { |v| v.permit(:name, :email, :password, :current_password) }
    end
    
    def find_djs
      @djs = User.find(:all, :conditions => ['dj_id IS ?', nil])
    end
end