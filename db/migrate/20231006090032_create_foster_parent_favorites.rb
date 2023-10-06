class CreateFosterParentFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :foster_parent_favorites do |t|
      t.integer :customer_id
      t.integer :foster_parent_id

      t.timestamps
    end
  end
end
