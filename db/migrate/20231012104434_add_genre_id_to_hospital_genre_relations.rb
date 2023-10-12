class AddGenreIdToHospitalGenreRelations < ActiveRecord::Migration[6.1]
  def change
    add_column :hospital_genre_relations, :genre_id, :integer
    add_column :hospital_genre_relations, :hospital_id, :integer
  end
end
