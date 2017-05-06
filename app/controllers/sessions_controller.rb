class SessionsController < ApplicationController
  before_action :require_login, only: [:show, :destroy]
  before_action :require_logout, except: [:show, :destroy]

  def new

  end

  def show
    @user = current_user

    render 'users/show'
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Username or password not found"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end