class Category < ActiveRecord::Base
  
  has_many :ideas

  validates :name, presence: true
  validates :name, length: { maximum: 80 }
  validates :order, uniqueness: true

end
