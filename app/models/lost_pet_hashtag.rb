class LostPetHashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum:99}
  has_many :lost_pet_hashtag_relations, dependent: :destroy
  has_many :lost_pets, through: :lost_pet_hashtag_relations
end
