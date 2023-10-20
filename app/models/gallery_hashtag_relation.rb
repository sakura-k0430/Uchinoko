class GalleryHashtagRelation < ApplicationRecord
  belongs_to :gallery
  belongs_to :gallery_hashtag
  with_options presence: true do
    validates :gallery_id
    validates :gallery_hashtag_id
  end
end