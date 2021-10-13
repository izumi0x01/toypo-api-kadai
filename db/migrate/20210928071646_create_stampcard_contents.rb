class CreateStampcardContents < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcard_contents do |t|
      t.references :store, index: true, foreign_key: true

      t.integer :max_stamp_count

      # 実際
      # t.integer :valid_day

      t.timestamps
    end
  end
end
