class Tag < ActiveRecord::Base
	belongs_to :topic

	attr_accessible :topic_id
end
