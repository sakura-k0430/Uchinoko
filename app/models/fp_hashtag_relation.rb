class FpHashtagRelation < ApplicationRecord
  belongs_to :foster_parent
  belongs_to :foster_parent_hashtag
  with_options presence: true do
    validates :foster_parent_id
    validates :foster_parent_hashtag_id
  end
end
