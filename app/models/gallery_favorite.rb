class GalleryFavorite < ApplicationRecord
  belongs_to :customer
  belongs_to :gallery
end
