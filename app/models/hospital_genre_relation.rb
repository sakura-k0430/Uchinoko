class HospitalGenreRelation < ApplicationRecord
  belongs_to :hospital
  belongs_to :genre
end
