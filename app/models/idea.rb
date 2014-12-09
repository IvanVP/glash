class Idea < ActiveRecord::Base
  attr_readonly :comments_count

  belongs_to :user
  belongs_to :category
  has_many :assets,   as: :attachable,  :dependent => :destroy
  has_many :comments, as: :commentable, :dependent => :destroy

  acts_as_votable

  scope :drafted,   -> { where(published: false) }
  scope :published, -> { where(published: true).where(moderated: false) }
  scope :active, -> { where(moderated: true).where(archieved: false).order('moderated_at DESC') }
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

  def status_info?
    status == :info
  end

  def status_idea?
    status == :idea
  end

  
end
