class CreateChemicalReactions < ActiveRecord::Migration
  def change
    create_table :chemical_reactions do |t|
    	t.belongs_to :image
    	t.text :description
    	t.integer :position

    	t.belongs_to :topic
    	t.belongs_to :chapter
      t.belongs_to :sub_heading
      t.belongs_to :example

      t.timestamps null: false
    end
  end
end
