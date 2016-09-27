class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :file
    	t.string :imageable_type
    	t.belongs_to :imageable, polymorphic: true
    	
      t.timestamps null: false
    end
  end
end
