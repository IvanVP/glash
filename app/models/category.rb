class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 80 }
  validates :order, uniqueness: true
end
