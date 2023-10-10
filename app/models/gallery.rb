class Gallery < ApplicationRecord
  has_one_attached :gallery_image
  belongs_to :customer
  has_many :gallery_comments, dependent: :destroy
  has_many :gallery_favorites, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :gallery_image, presence: true

  # 引数で渡されたユーザidがgallery_favoritesテーブル内に存在（exists?）するか確認
  def favorited_by?(customer)
    gallery_favorites.exists?(customer_id: customer.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      @gallery = Gallery.where("title LIKE? OR body LIKE?","#{word}","#{word}")
    # 前方一致
    elsif search == "forward_match"
      @gallery = Gallery.where("title LIKE? OR body LIKE?","#{word}%","#{word}%")
    # 後方一致
    elsif search == "backward_match"
      @gallery = Gallery.where("title LIKE? OR body LIKE?","%#{word}","%#{word}")
    # 部分一致
    elsif search == "partial_match"
      @gallery = Gallery.where("title LIKE? OR body LIKE?","%#{word}%","%#{word}%")
    else
      @gallery = Gallery.all
    end
  end
end
