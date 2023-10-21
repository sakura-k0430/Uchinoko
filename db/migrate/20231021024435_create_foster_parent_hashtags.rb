class CreateFosterParentHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :foster_parent_hashtags do |t|
      t.string :hashname
      t.timestamps
    end
  end
end
