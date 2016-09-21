class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :adress
      t.boolean :paid, default: false
      t.integer :amount
      t.integer :items_count
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
