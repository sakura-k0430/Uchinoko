class Genre < ApplicationRecord
  has_many :hospital_genre_relations, dependent: :destroy
  # 中間テーブルのhospital_genre_relationsを経由して、関連付け
  has_many :hospitals, through: :hospital_genre_relations

  def self.looks(search, word)
    if search == "perfect_match"
      @genre = Genre.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @genre = Genre.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @genre = Genre.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @genre = Genre.where("name LIKE?","%#{word}%")
    else
      @genre = Genre.all
    end
  end

end
