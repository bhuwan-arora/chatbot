class Quote < ActiveRecord::Base
	belongs_to :topic
	belongs_to :chapter
	belongs_to :sub_heading
	attr_accessible :position, :content, :author, :chapter_id, :sub_heading_id, :topic_id
end
