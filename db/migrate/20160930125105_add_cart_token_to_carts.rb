class AddCartTokenToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :cart_token, :string
  end
end
