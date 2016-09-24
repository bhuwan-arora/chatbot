class ChapterIndex < ActiveRecord::Base
	belongs_to :chapter
	attr_accessible :content, :chapter_id

end
