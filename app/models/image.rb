class Image < ActiveRecord::Base
	belongs_to :topic
	belongs_to :chapter
	belongs_to :chemical_reaction
	belongs_to :table
	belongs_to :sub_heading
	belongs_to :example
	attr_accessible :topic_id, :chapter_id, :name, :description, :position, :chemical_reaction_id, :table_id, :sub_heading_id, :example_id
end
