class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
    	t.text :content
    	t.string :author
    	t.integer :position

    	t.belongs_to :topic
    	t.belongs_to :chapter
      t.belongs_to :sub_heading

      t.timestamps null: false
    end
  end
end
