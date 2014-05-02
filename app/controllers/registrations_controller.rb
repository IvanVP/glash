class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:fname, :lname, :name, :email, :terms, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) } 
    devise_parameter_sanitizer.for(:account_update) {
      |u| u.permit(:fname, :mname, :lname, :name, :email, 
        :birthdate, :show_birthdate, :gender, :show_gender, :description, 
        :slug, :password, :password_confirmation, :current_password)}
  end

end

