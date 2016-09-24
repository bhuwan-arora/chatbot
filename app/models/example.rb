class Example < ActiveRecord::Base
	belongs_to :topic
	has_many :images, :class_name => "Image"
	has_many :tables, :class_name => "Table"
	has_many :paragraphs, :class_name => "Paragraph"
	has_many :chemical_reactions, :class_name => "ChemicalReaction"
	
	attr_accessible :topic_id, :element_count, :position, :name

	def increment_element_count
		self.update(:element_count => self.element_count + 1)
	end
end
