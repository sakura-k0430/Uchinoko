class LostPet < ApplicationRecord
  has_one_attached :lost_pet_image
  belongs_to :customer
  has_many :lost_pet_comments, dependent: :destroy
  has_many :lost_pet_favorites, dependent: :destroy

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

end