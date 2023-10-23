class LostPet < ApplicationRecord
  has_one_attached :lost_pet_image
  belongs_to :customer
  has_many :lost_pet_comments, dependent: :destroy
  has_many :lost_pet_favorites, dependent: :destroy
   has_many :lost_pet_hashtag_relations, dependent: :destroy
  has_many :lost_pet_hashtags, through: :lost_pet_hashtag_relations
  validates :title, presence: true
  validates :body, presence: true
  validates :lost_pet_image, presence: true

  # 引数で渡されたユーザidがlost_pet_favoritesテーブル内に存在（exists?）するか確認
  def favorited_by?(customer)
    lost_pet_favorites.exists?(customer_id: customer.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @lost_pet = LostPet.where("title LIKE? OR body LIKE?","#{word}","#{word}")
    elsif search == "forward_match"
      @lost_pet = LostPet.where("title LIKE? OR body LIKE?","#{word}%","#{word}%")
    elsif search == "backward_match"
      @lost_pet = LostPet.where("title LIKE? OR body LIKE?","%#{word}","%#{word}")
    elsif search == "partial_match"
      @lost_pet = LostPet.where("title LIKE? OR body LIKE?","%#{word}%","%#{word}%")
    else
      @lost_pet = LostPet.all
    end
  end

  # ハッシュタグ
  #DBへのコミット直前に実施する
  after_create do
    lost_pet = LostPet.find_by(id: self.id)
    lost_pet_hashtags  = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    lost_pet.lost_pet_hashtags = []
    lost_pet_hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = LostPetHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      lost_pet.lost_pet_hashtags << tag
    end
  end

  before_update do
    lost_pet = LostPet.find_by(id: self.id)
    lost_pet.lost_pet_hashtags.clear
    lost_pet_hashtags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    lost_pet_hashtags.uniq.map do |hashtag|
      tag = LostPetHashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      lost_pet.lost_pet_hashtags << tag
    end
  end

end