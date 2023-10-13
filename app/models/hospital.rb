class Hospital < ApplicationRecord
  has_one_attached :hospital_image
  has_many :hospital_genre_relations, dependent: :destroy
  # 中間テーブルのhospital_genre_relationsを経由して、関連付け
  has_many :genres, through: :hospital_genre_relations

  def self.looks(search, word)
    if search == "perfect_match"
      @hospital = Hospital.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @hospital = Hospital.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @hospital = Hospital.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @hospital = Hospital.where("name LIKE?","%#{word}%")
    else
      @hospital = Hospital.all
    end
  end

end
