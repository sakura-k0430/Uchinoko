class CreateFosterParents < ActiveRecord::Migration[6.1]
  def change
    create_table :foster_parents do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
