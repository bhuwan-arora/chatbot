class CreateActiveLearningQuestions < ActiveRecord::Migration
  def change
    create_table :active_learning_questions do |t|
    	t.integer :index
    	t.text :content
    	t.belongs_to :chapter
    	
      t.timestamps null: false
    end
  end
end
