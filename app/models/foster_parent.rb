class FosterParent < ApplicationRecord
  has_one_attached :foster_parent_image
  belongs_to :customer
end
