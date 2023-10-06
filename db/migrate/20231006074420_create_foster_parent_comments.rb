class CreateFosterParentComments < ActiveRecord::Migration[6.1]
  def change
    create_table :foster_parent_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :foster_parent_id

      t.timestamps
    end
  end
end
