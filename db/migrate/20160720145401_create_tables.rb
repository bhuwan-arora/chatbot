class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
    	t.text :content
    	t.integer :position

    	t.belongs_to :topic
    	t.belongs_to :chapter
      t.belongs_to :sub_heading
      t.belongs_to :example
    	
      t.timestamps null: false
    end
  end
end
