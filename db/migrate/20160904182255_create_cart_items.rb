class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :quantity, default: 1
      t.integer :price
      t.belongs_to :cart
      t.belongs_to :product

      t.timestamps null: false
    end
  end
end
