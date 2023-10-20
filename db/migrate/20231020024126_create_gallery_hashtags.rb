class CreateGalleryHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_hashtags do |t|
      t.string :hashname
      t.timestamps
    end
  end
end
