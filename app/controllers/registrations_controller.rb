class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:fname, :lname, :name, :email, :terms, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) } 
    devise_parameter_sanitizer.for(:account_update) {
      |u| u.permit(:fname, :mname, :lname, :name, :email, :avatar,
        :birthdate, :show_birthdate, :gender, :show_gender, :country_id, :description, 
        :slug, :password, :password_confirmation, :current_password)}
  end

  # user_path(current_user)

  protected

  def after_sign_up_path_for(resource)
    greetings_path
  end

  def after_update_path_for(resource)
    user_path(resource)
  end


end

