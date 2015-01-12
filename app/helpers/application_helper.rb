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

  def newest_ideas
    Idea.newest
  end

  def main_page_ideas
    Idea.main_page
  end

  def current_page(page,action)
    if controller.controller_name.to_s == page && controller.action_name.to_s == action
      'active'
    else
      ''
   end
  end

  def check_help_pages
    if @cms_page && @cms_site.path == "help"
      help_root = Comfy::Cms::Page.find_by(site_id: 2, full_path: "/")
      @help_menu_items = help_root.children
      return @help_menu_items
    else
      return nil
    end
  end

end
