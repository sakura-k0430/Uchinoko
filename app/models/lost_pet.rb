class LostPet < ApplicationRecord
  has_one_attached :lost_pet_image
  belongs_to :customer
  has_many :lost_pet_comments, dependent: :destroy
end
