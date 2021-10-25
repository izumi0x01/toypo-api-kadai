class CreateStampcards < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcards do |t|
      t.references :user, null: false, index: true, foreign_key: true
      t.references :stampcard_content, index: true, foreign_key: true
      t.integer :stamp_count

      t.timestamps
    end
  end
end
