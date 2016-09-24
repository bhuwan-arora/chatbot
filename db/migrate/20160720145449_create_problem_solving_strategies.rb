class CreateProblemSolvingStrategies < ActiveRecord::Migration
  def change
    create_table :problem_solving_strategies do |t|
    	t.text :content
    	
      t.timestamps null: false
    end
  end
end
