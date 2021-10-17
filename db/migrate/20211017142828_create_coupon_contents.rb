class CreateCouponContents < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_contents do |t|

      t.timestamps
    end
  end
end
