class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
	  t.string :name
	  t.integer :number
	  t.integer :element_count

      t.timestamps null: false
    end
  end
end
