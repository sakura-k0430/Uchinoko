class CreateGalleryComments < ActiveRecord::Migration[6.1]
  def change
    create_table :gallery_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :gallery_id

      t.timestamps
    end
  end
end
