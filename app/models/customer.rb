class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :galleries, dependent: :destroy
  has_many :lost_pets, dependent: :destroy
  has_many :foster_parents, dependent: :destroy
  has_many :gallery_comments, dependent: :destroy
  has_many :lost_pet_comments, dependent: :destroy
  has_many :foster_parent_comments, dependent: :destroy
  has_many :gallery_favorites, dependent: :destroy
  has_many :lost_pet_favorites, dependent: :destroy
  has_many :foster_parent_favorites, dependent: :destroy

  # プロフィール画像の表示のための定義
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # ログイン時に退会済みのユーザーが同じアカウントでログイン出来ないようにする
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end

end
