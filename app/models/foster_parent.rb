class FosterParent < ApplicationRecord
  has_one_attached :foster_parent_image
  belongs_to :customer
  has_many :foster_parent_comments, dependent: :destroy
  has_many :foster_parent_favorites, dependent: :destroy
  has_many :fp_hashtag_relations, dependent: :destroy
  has_many :foster_parent_hashtags, through: :fp_hashtag_relations
  validates :title, presence: true
  validates :body, presence: true
  validates :foster_parent_image, presence: true

  # 引数で渡されたユーザidがfoster_parent_favoritesテーブル内に存在（exists?）するか確認
  def favorited_by?(customer)
    foster_parent_favorites.exists?(customer_id: customer.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @foster_parent = FosterParent.where("title LIKE? OR body LIKE?","#{word}","#{word}")
    elsif search == "forward_match"
      @foster_parent = FosterParent.where("title LIKE? OR body LIKE?","#{word}%","#{word}%")
    elsif search == "backward_match"
      @foster_parent = FosterParent.where("title LIKE? OR body LIKE?","%#{word}","%#{word}")
    elsif search == "partial_match"
      @foster_parent = FosterParent.where("title LIKE? OR body LIKE?","%#{word}%","%#{word}%")
    else
      @foster_parent = FosterParent.all
    end
  end

  # ハッシュタグ
  #DBへのコミット直前に実施する
  after_create do
    foster_parent = FosterParent.find_by(id: self.id)
    foster_parent_hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    foster_parent.foster_parent_hashtags = []
    foster_parent_hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = FosterParentHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      foster_parent.foster_parent_hashtags << tag
    end
  end

  before_update do
    foster_parent = FosterParent.find_by(id: self.id)
    foster_parent.foster_parent_hashtags.clear
    foster_parent_hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    foster_parent_hashtags.uniq.map do |hashtag|
      tag = FosterParentHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      foster_parent.foster_parent_hashtags << tag
    end
  end

end