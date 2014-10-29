class IdeaImage < ActiveRecord::Base
  belongs_to :idea
  
  has_attached_file :image, :styles => { :thumb => "150x150>", :large => "800x450>" }, :default_url => "/images/:style/missing.png", :processors => [:cropper]
  validates_attachment :image, 
    :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates :image, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :image
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 3.megabytes
end
