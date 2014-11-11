module IdeasHelper

  def image_for_idea(idea)
    images = idea.assets
    image = images.first unless images.nil?
    image_path(image ? image.url : 'defaultidea.jpg')
  end

  def css_for_link
    link_css = "btn btn-primary btn-large"
    link_css << " disabled" unless user_signed_in?
    link_css
  end
  
end
