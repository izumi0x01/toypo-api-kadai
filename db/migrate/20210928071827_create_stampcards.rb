class CreateStampcards < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcards do |t|
      t.reference :user, index: true, foreign_key: true
      t.reference :stampcard_content, index: true, foreign_key: true
      t.integer :stamp_count

      t.timestamps
    end
  end
end
