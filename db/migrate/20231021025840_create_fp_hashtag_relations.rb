class CreateFpHashtagRelations < ActiveRecord::Migration[6.1]
  # テーブル名が長すぎて設定できないためやむを得ず中間テーブルのみfoster_parentをfpと省略
  def change
    create_table :fp_hashtag_relations do |t|
      t.references :foster_parent, index: true, foreign_key: true
      t.references :foster_parent_hashtag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
