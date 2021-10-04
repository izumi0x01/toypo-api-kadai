class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.integer :user_id, null: false
      #t.reference :user, null: false

      t.integer :store_id, null: false
      t.timestamps
    end

    add_index :connections, [:user_id, :store_id], unique: true
  end
end
