class GalleryHashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum:99}
  has_many :gallery_hashtag_relations, dependent: :destroy
  has_many :galleries, through: :gallery_hashtag_relations
end
