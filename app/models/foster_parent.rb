class FosterParent < ApplicationRecord
  has_one_attached :foster_parent_image
  belongs_to :customer
  has_many :foster_parent_comments, dependent: :destroy
  has_many :foster_parent_favorites, dependent: :destroy
end

def foster_parent_favorited_by?(customer)
    foster_parent_favorites.exists?(customer_id: customer.id)
end