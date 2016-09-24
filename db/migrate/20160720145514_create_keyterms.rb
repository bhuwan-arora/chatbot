class CreateKeyterms < ActiveRecord::Migration
  def change
    create_table :keyterms do |t|
    	t.string :name
    	t.belongs_to :chapter

      t.timestamps null: false
    end
  end
end
