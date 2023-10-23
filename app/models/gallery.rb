class Gallery < ApplicationRecord
  has_one_attached :gallery_image
  belongs_to :customer
  has_many :gallery_comments, dependent: :destroy
  has_many :gallery_favorites, dependent: :destroy
  has_many :gallery_hashtag_relations, dependent: :destroy
  has_many :gallery_hashtags, through: :gallery_hashtag_relations
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

  # ハッシュタグ
  #DBへのコミット直前に実施する
  after_create do
    gallery = Gallery.find_by(id: self.id)
    gallery_hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    gallery.gallery_hashtags = []
    gallery_hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = GalleryHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      gallery.gallery_hashtags << tag
    end
  end

  before_update do
    gallery = Gallery.find_by(id: self.id)
    gallery.gallery_hashtags.clear
    gallery_hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    gallery_hashtags.uniq.map do |hashtag|
      tag = GalleryHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      gallery.gallery_hashtags << tag
    end
  end

end
