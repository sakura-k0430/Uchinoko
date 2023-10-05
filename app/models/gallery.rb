class Gallery < ApplicationRecord
  has_one_attached :gallery_image
  belongs_to :customer
end
