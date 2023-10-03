class CreateFosterParents < ActiveRecord::Migration[6.1]
  def change
    create_table :foster_parents do |t|

      t.timestamps
    end
  end
end
