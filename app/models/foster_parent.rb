class FosterParent < ApplicationRecord
  has_one_attached :foster_parent_image
  belongs_to :customer
  has_many :foster_parent_comments, dependent: :destroy
  has_many :foster_parent_favorites, dependent: :destroy

  def favorited_by?(customer)
    foster_parent_favorites.exists?(customer_id: customer.id)
  end

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @foster_parent = FosterParent.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @foster_parent = FosterParent.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @foster_parent = FosterParent.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @foster_parent = FosterParent.where("title LIKE?","%#{word}%")
    else
      @foster_parent = FosterParent.all
    end
  end

end