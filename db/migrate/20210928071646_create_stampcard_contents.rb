class CreateStampcardContents < ActiveRecord::Migration[5.2]
  def change
    create_table :stampcard_contents do |t|
      t.references :store, index: true, foreign_key: true

      t.integer :max_stamp_count

      # 有効期限をつけるにはどうすればいい
      # t.datetime :valid_period

      t.timestamps
    end
  end
end
