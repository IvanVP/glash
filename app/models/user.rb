class User < ActiveRecord::Base
  extend FriendlyId

  has_one :contact, :dependent => :destroy

  attr_accessor :login
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  
  validates :fname, :lname, :name, :email, :presence => true
  validates :name, :email, :slug, :uniqueness => { :case_sensitive => false }
  
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

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :russian #[:russian, :latin]
  end

end
