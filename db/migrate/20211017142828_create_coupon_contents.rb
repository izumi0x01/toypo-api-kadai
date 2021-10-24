class CreateCouponContents < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_contents do |t|

      t.references :store, null: false, index: true, foreign_key: true
      t.references :stampcard_content, null: false, index: true, foreign_key: true
      t.string :name, null: false
      t.integer :required_stamp_count, null: false
      t.integer :valid_day, null: false

      t.timestamps
    end
  end
end
