class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    #外部キー制約が必要？
    create_table :connections do |t|
      t.references :user, null: false
      #t.reference :user, null: false

      t.references :store, null: false
      t.timestamps
    end

    add_index :connections, [:user_id, :store_id], unique: true
  end
end
