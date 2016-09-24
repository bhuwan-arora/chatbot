class Link < ActiveRecord::Base
	belongs_to :topic
	attr_accessible :topic_id, :url, :name
end
