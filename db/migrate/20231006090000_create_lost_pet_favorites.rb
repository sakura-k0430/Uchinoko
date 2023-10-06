class CreateLostPetFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pet_favorites do |t|
      t.integer :customer_id
      t.integer :lost_pet_id

      t.timestamps
    end
  end
end
