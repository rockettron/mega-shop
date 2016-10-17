class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
    	t.text :topic
    	t.string :image
    	t.boolean :visible, default: false
    	
      t.timestamps null: false
    end
  end
end
