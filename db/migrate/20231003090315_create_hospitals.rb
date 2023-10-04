class CreateHospitals < ActiveRecord::Migration[6.1]
  def change
    create_table :hospitals do |t|
       t.integer :genre_id, null: false
       t.string :name, null: false
       t.string :phone_number, null: false
       t.string :explanation, null: false
       t.string :address, null: false

      t.timestamps
    end
  end
end
