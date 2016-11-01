class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
    	t.belongs_to :profile
    	t.string :number
    	t.boolean :default, default: false
    	
      t.timestamps null: false
    end
  end
end
