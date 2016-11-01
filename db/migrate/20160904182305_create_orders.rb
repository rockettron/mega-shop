class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.boolean :paid, default: false
      t.integer :amount
      t.string :phone_number
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
