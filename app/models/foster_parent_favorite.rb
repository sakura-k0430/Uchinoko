class FosterParentFavorite < ApplicationRecord
  belongs_to :customer
  belongs_to :foster_parent
end