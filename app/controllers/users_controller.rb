class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create, :show]
  before_action :require_logout, only: [:new]
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show

  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Account created."
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end