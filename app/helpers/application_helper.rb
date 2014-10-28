module ApplicationHelper
  def title(page_title)
    content_for(:title){ "Glash - #{page_title}" }
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def most_active_users
    User.most_active
  end

  def current_page(page,action)
    if controller.controller_name.to_s == page && controller.action_name.to_s == action
      'active'
    else
      ''
   end
  end

end
