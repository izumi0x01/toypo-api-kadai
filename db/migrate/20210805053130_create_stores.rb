class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :store_name, null: false
      t.string :store_description
      t.string :email, null: false
      t.string :hashed_password

      t.timestamps
    end
    add_index :stores, "LOWER(email)", unique: true

  end
end
