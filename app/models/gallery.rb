class Gallery < ApplicationRecord
  has_one_attached :gallery_image
  belongs_to :customer
  has_many :gallery_comments, dependent: :destroy
  has_many :gallery_favorites, dependent: :destroy
  
  def favorited_by?(customer)
    gallery_favorites.exists?(customer_id: customer.id)
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @gallery = Gallery.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @gallery = Gallery.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @gallery = Gallery.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @gallery = Gallery.where("title LIKE?","%#{word}%")
    else
      @gallery = Gallery.all
    end
  end
end
