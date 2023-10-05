class LostPet < ApplicationRecord
  has_one_attached :lost_pet_image
  belongs_to :customer
end
