class LostPet < ApplicationRecord
  has_one_attached :lost_pet_image
  belongs_to :customer
  has_many :lost_pet_comments, dependent: :destroy
  has_many :lost_pet_favorites, dependent: :destroy
end

def lost_pet_favorited_by?(customer)
    lost_pet_favorites.exists?(customer_id: customer.id)
end
