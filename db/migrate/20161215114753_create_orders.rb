class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_address
      t.string :receiver_phone
      t.boolean :is_confirm, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
