class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
    	t.belongs_to :chapter
    	t.integer :element_count
    	t.integer :position
    	t.text :name
    	t.boolean :links_updated

      t.timestamps null: false
    end
  end
end
