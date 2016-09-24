class CreateChapterIndices < ActiveRecord::Migration
  def change
    create_table :chapter_indices do |t|
    	t.belongs_to :chapter
    	t.text :content
    	
      t.timestamps null: false
    end
  end
end
