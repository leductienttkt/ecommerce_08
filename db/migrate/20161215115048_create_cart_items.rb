class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: Settings.default.quantity_cart_item
      t.float :cart_price
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
