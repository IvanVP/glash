class Idea < ActiveRecord::Base
  # attr_accessor :idea_images
  attr_readonly :comments_count

  belongs_to :user
  belongs_to :category
  has_many :assets,   as: :attachable,  :dependent => :destroy
  has_many :comments, as: :commentable, :dependent => :destroy



  acts_as_votable


  # scope :newest, -> {published.order('updated_at DESC').first(5)}
  scope :drafted,   -> { where(published: false) }
  scope :published, -> { where(published: true).where(moderated: false) }
  scope :active, -> { where(moderated: true).where(archieved: false) }
  scope :archieved, -> { where(archieved: true) }
  scope :newest, -> {order('updated_at DESC').active.first(6)}

  accepts_nested_attributes_for :assets, allow_destroy: true, :reject_if => lambda { |t| t['data'].nil? }

  validates :agree, acceptance: true

  with_options if: :status_info? do |val|
    val.validates :title, :synopsis, :problem, presence: true
    val.validates :title, uniqueness: true 
    val.validates :title,    length: { in: 5..40 }
    val.validates :synopsis, length: { in: 5..150 }
    val.validates :problem,  length: { in: 5..2500 }
  end

  with_options if: :status_idea? do |val|
    val.validates :background, :solution, presence: true 
    val.validates :background, :solution, length: { in: 5..2500 }
    val.validates :links, length: { maximum: 1000 }
  end

  # validates_attachment :asset, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  # validates_attachment_content_type :asset, content_type: %w(image/jpeg image/jpg image/png)

 

  # validate :validate_attachments
    
  # Max_Attachments = 10
  # Max_Attachment_Size = 3.megabyte

  # def validate_attachments
  #   errors[:base]<<"Слишком много файлов - максимум #{Max_Attachments} файлов" if assets.length > Max_Attachments
  #   assets.each {|a| errors[:base]<<"#{a.name} превышает лимит размера файла в #{Max_Attachment_Size/1.megabyte}MB" if a.file_size > Max_Attachment_Size}
  # end

  def status_info?
    status == :info
  end

  def status_idea?
    status == :idea
  end


  
end
