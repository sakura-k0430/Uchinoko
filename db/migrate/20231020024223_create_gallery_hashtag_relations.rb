class CreateGalleryHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_hashtag_relations do |t|
      t.references :gallery, index: true, foreign_key: true
      t.references :gallery_hashtag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
