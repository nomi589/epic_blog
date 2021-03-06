class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    if !logged_in?
      flash[:error] = "You need to be logged in to access that resource"
      redirect_to root_path
    end
  end

  def require_logout
    redirect_to root_path if logged_in?
  end

  def set_back_path
    @back_path = request.referer
  end
end
