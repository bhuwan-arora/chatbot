class Table < ActiveRecord::Base
	belongs_to :topic
	belongs_to :chapter
	has_one :image
	belongs_to :sub_heading
	belongs_to :example
	attr_accessible :content, :topic_id, :chapter_id, :position, :sub_heading_id, :example_id
end
