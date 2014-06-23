module ApplicationHelper
  def title(page_title)
    content_for(:title){ "Glash - #{page_title}" }
  end

end
