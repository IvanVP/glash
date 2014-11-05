class Idea < ActiveRecord::Base
  # attr_accessor :idea_images

  belongs_to :user
  belongs_to :category
  has_many :assets, :as => :attachable
  # , :dependent => :destroy

  # has_many :idea_images

  accepts_nested_attributes_for :assets, allow_destroy: true, :reject_if => lambda { |t| t['data'].nil? }

  # validates :title, :synopsis, :problem, :background, :solution,
  #           presence: true
  # validates :title, length: { in: 5..40 }
  # validates :synopsis, length: { in: 5..150 }
  # validates :problem, :background, :solution, length: { in: 5..2500 }
  # # validates :background, length: { in: 5..2500 }
  # # validates :solution, length: { in: 5..2500 }
  # validates :links, length: { maximum: 1000 }
  # validates :title, uniqueness: true


  validates :agree, acceptance: true
  # {:accept => true}


  # validates_attachment :asset, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  # validates_attachment_content_type :asset, content_type: %w(image/jpeg image/jpg image/png)

 

  validate :validate_attachments
    
  Max_Attachments = 10
  Max_Attachment_Size = 3.megabyte

  def validate_attachments
    errors[:base]<<"Слишком много файлов - максимум #{Max_Attachments} файлов" if assets.length > Max_Attachments
    assets.each {|a| errors[:base]<<"#{a.name} превышает лимит размера файла в #{Max_Attachment_Size/1.megabyte}MB" if a.file_size > Max_Attachment_Size}
  end

  

  # def image_styles
  #   { :thumb => "150x150>", :normal => "800x450>" }
  # end

  

end
