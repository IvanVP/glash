class User < ActiveRecord::Base
  extend FriendlyId

  # constants

  # attr related macros
  attr_accessor :login, :crop_x, :crop_y, :crop_w, :crop_h, :processing

  #belongs_to
  has_one :contact, :dependent => :destroy
  belongs_to :roles
  belongs_to :countries

  validates :fname, :lname, :name, :email, :presence => true
  validates :name, :email, :slug, :uniqueness => { :case_sensitive => false }
  validates :terms, acceptance: {:accept => true}

  before_create :build_default_info
  after_update :reprocess_avatar, if: :cropping?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
        :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :large => "500x500>", :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png", :processors => [:cropper]

  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, 
    :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  friendly_id :slug_candidates, use:  [:slugged, :finders, :history]
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def slug_candidates
    [
      :lname,
      [:fname, :lname],
      :name
    ]
  end

  def fullname
    "#{self.fname} #{self.lname}"
  end

  def age
    ((Date.today - self.birthdate) / 365).floor
  end

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :russian #[:russian, :latin]
  end

  def is_admin?
    self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end


  private

  def build_default_info
    build_contact
    true
  end

  def reprocess_avatar
    return unless (cropping? && !processing)
    self.processing = true
    avatar.reprocess!
    self.processing = false
  end

  
end
