class CreateVoteOptions < ActiveRecord::Migration
  def change
    create_table :vote_options do |t|
    	t.string :title
    	t.integer :votes_count, default: 0
    	t.string :background_color, default: ""
    	t.string :text_color, default: ""
    	t.belongs_to :offer, index: true

      t.timestamps null: false
    end
  end
end
