class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
    	t.string :name
    	t.text :url

    	t.belongs_to :topic
    	
      t.timestamps null: false
    end
  end
end
