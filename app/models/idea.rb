class Idea < ActiveRecord::Base
  # attr_accessor :idea_images

  belongs_to :user
  belongs_to :category
  # has_many :idea_images

  validates :title, :synopsis, :problem, :background, :solution,
            presence: true
  validates :title, length: { in: 5..40 }
  validates :synopsis, length: { in: 5..150 }
  validates :problem, :background, :solution, length: { in: 5..2500 }
  # validates :background, length: { in: 5..2500 }
  # validates :solution, length: { in: 5..2500 }
  validates :links, length: { maximum: 1000 }
  validates :title, uniqueness: true

  # accepts_nested_attributes_for :idea_images
  # , :reject_if => lambda { |t| t['idea_image'].nil? }
end
