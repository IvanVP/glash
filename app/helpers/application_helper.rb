module ApplicationHelper
  def title(page_title)
    content_for(:title){ "Glash - #{page_title}" }
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

end
