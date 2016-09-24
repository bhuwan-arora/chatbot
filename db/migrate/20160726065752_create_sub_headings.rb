class CreateSubHeadings < ActiveRecord::Migration
  def change
    create_table :sub_headings do |t|
    	t.string :name
    	t.integer :element_count
    	t.integer :position
    	t.belongs_to :topic

      t.timestamps null: false
    end
  end
end
