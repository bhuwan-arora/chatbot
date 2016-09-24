class Chapter < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :number, presence: true, uniqueness: true
	validates :element_count, presence: true
	has_one :chapter_index,  :class_name => "ChapterIndex"
	has_one :keyterm, :class_name => "Keyterm" 
	has_one :for_review, :class_name => "ForReview"
	has_many :quotes, :class_name => "Quote"
	has_many :topics, :class_name => "Topic"
	has_many :images, :class_name => "Image"
	has_many :tables, :class_name => "Table"
	has_many :paragraphs, :class_name => "Paragraph"
	has_many :chemical_reactions, :class_name => "ChemicalReaction"
	has_many :active_learning_questions, :class_name => "ActiveLearningQuestion"

	def increment_element_count
		self.update(:element_count => self.element_count + 1)
	end

end