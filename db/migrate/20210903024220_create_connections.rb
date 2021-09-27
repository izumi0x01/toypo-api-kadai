class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :store_id
      t.timestamps
    end

    add_index :connections, [:user_id, :store_id], unique: true
  end
end
