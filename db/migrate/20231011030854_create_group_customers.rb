class CreateGroupCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_customers do |t|
      # references型は作成済みのテーブルを指定する場合に使用
      t.references :customer, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
