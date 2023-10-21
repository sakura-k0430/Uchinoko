class FosterParentHashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum:99}
  has_many :fp_hashtag_relations
  has_many :foster_parents, through: :fp_hashtag_relations
end
