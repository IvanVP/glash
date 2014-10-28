class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :title, :synopsis, :problem, :background, :solution,
            presence: true
  validates :title, length: { in: 5..40 }
  validates :synopsis, length: { in: 5..150 }
  validates :problem, :background, :solution, length: { in: 5..2500 }
  # validates :background, length: { in: 5..2500 }
  # validates :solution, length: { in: 5..2500 }
  validates :links, length: { maximum: 1000 }
  validates :title, uniqueness: true
end
