class RemoveGenreIdFromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :genre_id, :integer
  end
end
