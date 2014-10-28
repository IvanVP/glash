class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def after_sign_out_path_for(resource)
    goodbye_path
  end

  protected

  def after_sign_in_path_for(resource)
    ideas_path
  end

end
