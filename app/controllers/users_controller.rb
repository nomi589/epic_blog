class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create, :show]
  before_action :require_logout, only: [:new]
  before_action :set_user, only: [:show, :edit, :update, :confirm_delete, :destroy]
  before_action :require_authorized_user, only: [:edit, :confirm_delete, :destroy]
  before_action :set_back_path, only: [:new, :edit, :confirm_delete]

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

  def confirm_delete

  end

  def destroy
    session.delete(:user_id)
    @user.destroy
    flash[:notice] = "Account deleted"
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit!
  end

  def require_authorized_user
    if @user != current_user
      flash[:error] = "Access denied"
      redirect_to root_path
    end
  end
end