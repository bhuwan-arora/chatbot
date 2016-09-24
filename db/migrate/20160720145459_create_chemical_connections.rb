class CreateChemicalConnections < ActiveRecord::Migration
  def change
    create_table :chemical_connections do |t|
    	t.text :content
    	
      t.timestamps null: false
    end
  end
end
