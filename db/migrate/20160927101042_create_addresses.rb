class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.belongs_to :profile
    	t.string :postcode
    	t.string :address
    	t.boolean :default
      t.timestamps null: false
    end
  end
end
