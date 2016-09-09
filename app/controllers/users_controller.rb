class UsersController < ApplicationController

  layout false

  before_action :require_user, :require_admin, only: [:admin, :destroy]
  before_action :require_no_login, only: [:index]
  before_action :require_admin,     only: :destroy
  skip_before_filter :verify_authenticity_token, :only => :destroy
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def admin
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to '/admin'
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    # flash[:success] = "User deleted"
    redirect_to '/admin'
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
