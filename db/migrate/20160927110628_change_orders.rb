class ChangeOrders < ActiveRecord::Migration
  def change
  	rename_column :orders, :adress, :address
  	remove_column :orders, :items_count
  	add_column :orders, :phone_number, :string
  end
end
