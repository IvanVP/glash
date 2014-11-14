class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true,
                   length: { maximum: 2500 }

  # scope :descending, -> {order('created_at DESC')}


end
