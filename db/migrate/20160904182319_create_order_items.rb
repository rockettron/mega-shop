class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.integer :price
      t.belongs_to :order
      t.belongs_to :product

      t.timestamps null: false
    end
  end
end
