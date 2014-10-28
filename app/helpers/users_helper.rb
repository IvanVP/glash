module UsersHelper
  def user_css_klass?
    !current_page?(users_path) && ((params[:controller] == 'users' || params[:controller] == 'contacts' || params[:controller] == 'registrations') && !@user.nil? && (@user == current_user))
  end
end
