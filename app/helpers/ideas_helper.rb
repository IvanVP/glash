module IdeasHelper

  def image_for_idea(idea)
    images = idea.assets
    image = images.first unless images.nil?
    image_path(image ? image.url : 'defaultidea.jpg')
  end
  
end
