class CreateLostPets < ActiveRecord::Migration[6.1]
  def change
    create_table :lost_pets do |t|

      t.timestamps
    end
  end
end
