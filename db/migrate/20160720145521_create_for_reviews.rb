class CreateForReviews < ActiveRecord::Migration
  def change
    create_table :for_reviews do |t|
    	t.text :content
    	t.belongs_to :chapter

      t.timestamps null: false
    end
  end
end
