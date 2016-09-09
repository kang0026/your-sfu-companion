class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # helper_method :current_user 

  # def current_user 
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  # end
  
  # def require_user 
  #   redirect_to '/login' unless current_user 
  # end
  
  # def require_admin
  #   redirect_to '/' unless current_user.email == "admin@email.com"
  # end
  
  # def require_no_login
  #   redirect_to '/welcome' unless !current_user
  # end
  
  #############
  # before_action :require_user, only: [:index, :show]
  #add the above line in whatever controller that needs user login to be accessed.
  ##################
  
  protect_from_forgery with: :exception;
  include SessionsHelper
end
