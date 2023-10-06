class FosterParent < ApplicationRecord
  has_one_attached :foster_parent_image
  belongs_to :customer
  has_many :foster_parent_comments, dependent: :destroy
end
