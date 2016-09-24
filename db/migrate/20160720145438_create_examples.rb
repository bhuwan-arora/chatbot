class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
    	t.text :content
    	t.belongs_to :topic
    	t.integer :position
    	t.integer :element_count
    	t.text :name

      t.timestamps null: false
    end
  end
end
