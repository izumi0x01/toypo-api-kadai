class CreateStampcards < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcards do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :stampcard_content, index: true, foreign_key: true
      t.integer :stamp_count

      t.timestamps
    end
  end
end
