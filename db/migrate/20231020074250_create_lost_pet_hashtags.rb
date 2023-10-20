class CreateLostPetHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pet_hashtags do |t|
      t.string :hashname
      t.timestamps
    end
  end
end
