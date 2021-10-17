class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|

      t.references :user, null: false, index: true, foreign_key: true
      t.references :coupon_content, null: false, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
