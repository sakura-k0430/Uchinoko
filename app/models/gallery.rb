class Gallery < ApplicationRecord
  has_one_attached :gallery_image
  belongs_to :customer
  has_many :gallery_comments, dependent: :destroy
  has_many :gallery_favorites, dependent: :destroy
end

def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
end