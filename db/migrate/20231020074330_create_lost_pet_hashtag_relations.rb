class CreateLostPetHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pet_hashtag_relations do |t|
      t.references :lost_pet, index: true, foreign_key: true
      t.references :lost_pet_hashtag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
