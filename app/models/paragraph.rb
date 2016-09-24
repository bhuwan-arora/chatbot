class Paragraph < ActiveRecord::Base
	belongs_to :topic
	belongs_to :chapter
	belongs_to :sub_heading
	belongs_to :example
	attr_accessible :content, :position, :chapter_id, :topic_id, :sub_heading_id, :example_id

end
