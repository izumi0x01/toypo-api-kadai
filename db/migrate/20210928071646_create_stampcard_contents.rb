class CreateStampcardContents < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcard_contents do |t|
      t.belongs_to :shop, index: true, foreign_key: true
      t.integer :max_stamp_count
      t.datetime :valid_period

      t.timestamps
    end
  end
end
