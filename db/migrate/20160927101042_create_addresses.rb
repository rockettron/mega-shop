class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.belongs_to :profile
    	t.integer :postcode
    	t.string :address
    	t.boolean :default, default: false

      t.timestamps null: false
    end
  end
end
