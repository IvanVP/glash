class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action { |c| Authorization.current_user = c.current_user  }

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def after_sign_out_path_for(resource)
    goodbye_path
  end

  def permission_denied
    flash[:alert] = "Извините, Вы не можете сделать это действие (недостаточно прав или запрещен доступ). #{current_user.roles.map { |role| role.name.downcase.to_sym  } if current_user}"
    # redirect_to idea_url(Idea.find(1))
    redirect_to ideas_url
  end

  protected

  def after_sign_in_path_for(resource)
    ideas_path
  end

end
