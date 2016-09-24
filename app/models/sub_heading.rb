class SubHeading < ActiveRecord::Base
	belongs_to :topic
	validates :name, :presence => true
	attr_accessible :topic_id, :name, :element_count, :position
	has_many :quotes, :class_name => "Quote"
	has_many :images, :class_name => "Image"
	has_many :tables, :class_name => "Table"
	has_many :paragraphs, :class_name => "Paragraph"
	has_many :chemical_reactions, :class_name => "ChemicalReaction"

	def increment_element_count
		self.update(:element_count => self.element_count + 1)
	end

	def self.get_all_for_topic topic
		sub_headings = topic.sub_headings
		info = []
		for sub_heading in sub_headings do
			params = {
				:name => sub_heading.name,
				:id => sub_heading.id,
				:chapter_id => sub_heading.topic.chapter.number,
				:position =>  sub_heading.position,
				:element_count => sub_heading.element_count,
				:paragraphs => sub_heading.paragraphs.select(:id, :content, :position).map(&:attributes),
				:images => sub_heading.images.select(:id, :name, :description, :position).map(&:attributes),
				:tables => sub_heading.tables.select(:id, :content).map(&:attributes),
				:quotes => sub_heading.quotes.select(:id, :content, :position).map(&:attributes),
				:chemical_reactions => ChemicalReaction.get_with_images_for_sub_heading(sub_heading.id)
			}
			info.push params
		end
		info
	end
end