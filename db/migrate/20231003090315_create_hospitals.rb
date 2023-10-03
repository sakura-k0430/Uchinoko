class CreateHospitals < ActiveRecord::Migration[6.1]
  def change
    create_table :hospitals do |t|

      t.timestamps
    end
  end
end
