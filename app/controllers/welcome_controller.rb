class WelcomeController < ApplicationController
  layout false
  before_action :require_user, only: [:home, :show]
  
  def home
  end
end
