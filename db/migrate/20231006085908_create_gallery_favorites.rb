class CreateGalleryFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_favorites do |t|
      t.integer :customer_id
      t.integer :gallery_id

      t.timestamps
    end
  end
end
