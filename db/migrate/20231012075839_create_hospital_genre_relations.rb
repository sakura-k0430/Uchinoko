class CreateHospitalGenreRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :hospital_genre_relations do |t|

      t.timestamps
    end
  end
end
