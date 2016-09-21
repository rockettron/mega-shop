class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.boolean :status, default: true
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end