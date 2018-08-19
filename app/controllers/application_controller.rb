class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user=(user)
    if user
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def redirect_if_logged_in
    redirect_to(root_path) if current_user.present?
  end

  def redirect_if_logged_out
    redirect_to(sessions_new_path) if current_user.nil?
  end
end
