class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :orders_count
      t.string :remember_token, index: true
      t.string :role
      
      t.timestamps null: false
    end
  end
end
