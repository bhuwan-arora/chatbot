module DatabaseReader

	
	def self.print
		Chapter.all.each do |chapter|
			puts "NAME: #{chapter.name}".green
			puts "NUMBER: #{chapter.number}".green
			puts ("ELEMENT COUNT "+chapter.element_count.to_s).green

			puts "INDEX".red
			puts chapter.chapter_index.content
			
			puts "IMAGE".red
			chapter.images.each do |image|
				if image.chapter_id
					puts image.position.to_s.green + "  NAME " + image.name.to_s + " DESCRIPTION " + image.description.to_s
				end
			end
			
			puts "PARAGRAPH".red
			chapter.paragraphs.each do |paragraph|
				if paragraph.chapter_id
					puts paragraph.position.to_s.green + "   " + paragraph.content
				end
			end
			
			puts "QUOTE".red
			chapter.quotes.each do |quote|
				if quote.chapter_id
					puts quote.position.to_s.green + "   " + quote.content
				end
			end
			
			puts "TABLE".red
			chapter.tables.each do |table|
				if table.chapter_id
					puts table.position.to_s.green + "   " + table.image.name
				end
			end

			puts "CHEMICAL REACTION".red
			chapter.chemical_reactions.each do |chemical_reaction|
				if chemical_reaction.chapter_id
					puts chemical_reaction.position.to_s.green + "   " + chemical_reaction.image.name
				end
			end

			puts "TOPICS".red
			chapter.topics.each do |topic|
				puts topic.position.to_s.green
				puts ("    " + "HEADING " + topic.name).green
				puts ("    " + "ELEMENT COUNT "+topic.element_count.to_s).green
				
				puts "    LINKS".red
				topic.links.each do |link|
				end

				puts "    TAGS".red
				topic.tags.each do |tag|
				end

				puts "    " + "IMAGE".red
				topic.images.each do |image|
					if image.topic_id
						puts "    " + (topic.position.to_s + "-" + image.position.to_s).green + "  NAME " + image.name + " DESCRIPTION " + image.description.to_s
					end
				end
				
				puts "    " + "PARAGRAPH".red
				topic.paragraphs.each do |paragraph|
					if paragraph.topic_id
						puts "    " + (topic.position.to_s + "-" + paragraph.position.to_s).green + "   " + paragraph.content
					end
				end
				
				puts "    " + "QUOTE".red
				topic.quotes.each do |quote|
					if quote.topic_id
						puts "    " + (topic.position.to_s + "-" + quote.position.to_s).green + "   " + quote.content
					end
				end
				
				puts "    " + "TABLE".red
				topic.tables.each do |table|
					if table.topic_id
						puts "    " + (topic.position.to_s + "-" + table.position.to_s).green + "   " + table.image.name
					end
				end

				puts "    " + "CHEMICAL REACTION".red
				topic.chemical_reactions.each do |chemical_reaction|
					if chemical_reaction.topic_id
						puts "    " + (topic.position.to_s + "-" + chemical_reaction.position.to_s).green + "   " + chemical_reaction.image.name
					end
				end

				puts "-------------------------------------------------".green
				puts "-------------------------------------------------".green
				puts "     " + "SUBHEADING ".red
				topic.sub_headings.each do |sub_heading|
					puts sub_heading.position.to_s.green
					puts ("                     " + "SUB HEADING " + sub_heading.name).green
					puts ("                     " + "ELEMENT COUNT "+sub_heading.element_count.to_s).green

					puts "                  " + "IMAGE".red
					sub_heading.images.each do |image|
						puts "                  " + (topic.position.to_s + "-" + sub_heading.position.to_s + "-" + image.position.to_s).green + "  NAME " + image.name + " DESCRIPTION " + image.description.to_s
					end
					
					puts "                  " + "PARAGRAPH".red
					sub_heading.paragraphs.each do |paragraph|
						puts "                  " + (topic.position.to_s + "-" + sub_heading.position.to_s + "-" + paragraph.position.to_s).green + "   " + paragraph.content
					end
					
					puts "                  " + "QUOTE".red
					sub_heading.quotes.each do |quote|
						puts "                  " + (topic.position.to_s + "-" + sub_heading.position.to_s + "-" + quote.position.to_s).green + "   " + quote.content
					end
					
					puts "                  " + "TABLE".red
					sub_heading.tables.each do |table|
						puts "                  " + (topic.position.to_s + "-" + sub_heading.position.to_s + "-" + table.position.to_s).green + "   " + table.image.name
					end

					puts "                  " + "CHEMICAL REACTION".red
					sub_heading.chemical_reactions.each do |chemical_reaction|
						puts "                  " + (topic.position.to_s + "-" + sub_heading.position.to_s + "-" + chemical_reaction.position.to_s).green + "   " + chemical_reaction.image.name
					end

					puts "-------------------------------------------------".green
					puts "-------------------------------------------------".green
				end
				puts "****************************************************".green
				puts "****************************************************".green
			end

		end
	end
end