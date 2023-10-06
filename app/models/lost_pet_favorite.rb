class LostPetFavorite < ApplicationRecord
  belongs_to :customer
  belongs_to :lost_pet
end
