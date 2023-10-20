class LostPetHashtagRelation < ApplicationRecord
  belongs_to :lost_pet
  belongs_to :lost_pet_hashtag
  with_options presence: true do
    validates :lost_pet_id
    validates :lost_pet_hashtag_id
  end
end
