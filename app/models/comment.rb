class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :body, presence: true,
                   length: { maximum: 2500 }

  scope :unmoderated, -> {where(moderated: false)}

end
