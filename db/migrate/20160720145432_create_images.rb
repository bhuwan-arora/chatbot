class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :name
    	t.text :description
    	t.integer :position

    	t.belongs_to :chapter
      t.belongs_to :topic
      t.belongs_to :table
      t.belongs_to :chemical_reaction
      t.belongs_to :sub_heading
      t.belongs_to :example
    	
      t.timestamps null: false
    end
  end
end
