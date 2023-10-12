class Genre < ApplicationRecord
  has_many :hospital_genre_relations, dependent: :destroy
  # 中間テーブルのhospital_genre_relationsを経由して、関連付け
  has_many :hospitals, through: :hospital_genre_relations
end
