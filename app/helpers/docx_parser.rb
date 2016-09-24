module DocxParser
	HEADING = "heading"
	INDEX = "index"
	IMAGE = "image"
	QUOTE = "quote"
	CHEMICALREACTION = "chemicalreaction"
	TABLE = "table"
	EXAMPLE = "example"
	SUBHEADING = "subheading"
	SOLUTION = "solution"


	def self.init filepath
		self.init_variables filepath
		@doc.paragraphs.each do |p|
			isTag = p.to_s.include? "//"
			puts "#{p.to_s}".red
		  	if isTag
		  		self.handle_state_change p
		  	else
		  		self.handle_current_state p
		  	end
		end
	end

	def self.init_all
		chapters = [9, 10, 16, 17, 19]
		chapters.each do |chapter|
			@chapterNumber = chapter
			filepath = "app/assets/book/" + chapter.to_s + ".docx"
			self.init filepath
		end
	end

	def self.print_tags filepath
		puts "Chapter #{filepath}"
		@doc = Docx::Document.open filepath
		@doc.paragraphs.each do |p|
			isTag = p.to_s.include? "//"
			if isTag
				type = self.get_tag_type p
				tagsCaptured = type[:isIndex] || type[:isImage] || type[:isQuote] || type[:isChemicalReaction] || type[:isTable] || type[:isExample] || type[:isHeading] || type[:isSubHeading]
				if tagsCaptured
				 	puts p.to_s.green
			 	end 
			end
		end
	end

	def self.init_variables filepath
		puts "#{filepath}"
		@doc = Docx::Document.open filepath
		@chapterNumber ||= 9
		chapterName = "Chapter #{@chapterNumber}"
		puts "Chapter #{filepath}"
		@chapter = Chapter.new(:number => @chapterNumber, :name => chapterName, :element_count => 0)
		@chapter.save!
		@states = {}
		self.reset_content_states
		self.reset_content_wrappers
		puts "test".green
	end

	def self.reset_content_wrappers
		@states[:topicInitiated] = false
		@states[:subHeadingInitiated] = false
		@states[:exampleInitiated] = false
	end

	def self.reset_content_states
		@states[:indexInitiated] = false
		@states[:imageInitiated] = false
		@states[:quoteInitiated] = false
		@states[:chemicalReactionInitiated] = false
		@states[:tableInitiated] = false
		
		@var = {
			:chapterIndex => "",
			:image => {},
			:quote => "",
			:chemicalReaction => {},
			:example => {}
		}
	end

	def self.get_tag_type tag
		
		isHeading = MathsHelper.normalise_string(tag) == HEADING
  		isIndex = MathsHelper.normalise_string(tag) == INDEX
  		isImage = MathsHelper.normalise_string(tag) == IMAGE
  		isQuote = MathsHelper.normalise_string(tag) == QUOTE
  		isChemicalReaction = MathsHelper.normalise_string(tag) == CHEMICALREACTION
  		isTable = MathsHelper.normalise_string(tag) == TABLE
  		isExample = MathsHelper.normalise_string(tag) == EXAMPLE
  		isSubHeading = MathsHelper.normalise_string(tag) == SUBHEADING
  		isSolution = MathsHelper.normalise_string(tag) == SOLUTION

  		type = {
  			:isHeading => isHeading,
  			:isIndex => isIndex,
  			:isImage => isImage,
  			:isQuote => isQuote,
  			:isChemicalReaction => isChemicalReaction,
  			:isTable => isTable,
  			:isExample => isExample,
  			:isSubHeading => isSubHeading,
  			:isSolution => isSolution
  		}
  		type
	end

	def self.handle_state_change p
		puts "STATES #{@states}".green
		type = self.get_tag_type p
		self.handle_continuous_state_interrupt
		self.reset_content_states
  		
  		if type[:isIndex]

  			@states[:indexInitiated] = true
  		
  		elsif type[:isImage]

  			@states[:imageInitiated] = true
  		
  		elsif type[:isQuote]

  			@states[:quoteInitiated] = true
  		
  		elsif type[:isChemicalReaction]

  			@states[:chemicalReactionInitiated] = true
  		
  		elsif type[:isTable]

  			@states[:tableInitiated] = true

  		elsif type[:isExample]

  			self.reset_content_wrappers
  			if @example

  				@example = nil

  			end
  			
  			@states[:exampleInitiated] = true
  			@states[:topicInitiated] = true

  		elsif type[:isHeading]

  			self.reset_content_wrappers
  			if @topic

  				@topic.handle_links
				@topic.handle_tags
  				@topic = nil
  				@heading = nil

  			end

  			@states[:topicInitiated] = true
  			

  		elsif type[:isSubHeading]
  			self.reset_content_wrappers
  			if @subHeading

  				@subHeading = nil

  			end

  			@states[:topicInitiated] = true
  			@states[:subHeadingInitiated] = true
  		end
	end

	def self.handle_current_state p
		
		if @states[:indexInitiated]

  			@var[:chapterIndex] = @var[:chapterIndex] + "\n#{p.to_s}"
  		
  		elsif @states[:imageInitiated]

  			
  			if @var[:image][:name].present?

  				unless MathsHelper.is_empty? p

	  				@var[:image][:description] = p.to_s

	  				self.save_image
	  				self.reset_content_states

  				end
  			else

  				@var[:image][:name] = p.to_s

  			end
  		
  		elsif @states[:quoteInitiated]

  			@var[:quote] = @var[:quote] + "\n#{p.to_s}"
  		
  		elsif @states[:chemicalReactionInitiated]

  			if @var[:chemicalReaction][:name].present?

  				unless MathsHelper.is_empty? p

	  				@var[:chemicalReaction][:description] = p.to_s

	  				self.save_chemical_reaction
	  				self.reset_content_states

  				end
  			else

  				@var[:chemicalReaction][:name] = p.to_s

  			end
  		
  		elsif @states[:tableInitiated]


  			@var[:table] = {:name => p.to_s}
  			
  			self.save_table
  			self.reset_content_states

  		elsif @states[:exampleInitiated]

			unless @example.present?
				self.handle_example p unless MathsHelper.is_empty? p
			else
				self.save_paragraph p
			end

		elsif @states[:subHeadingInitiated]

			unless @subHeading.present?
				self.handle_sub_heading p unless MathsHelper.is_empty? p
			else
				self.save_paragraph p
			end

  		elsif @states[:topicInitiated]

  			unless @topic.present?
  				self.handle_topic p unless MathsHelper.is_empty? p
			else
				self.save_paragraph p
			end
				
		else

			self.save_paragraph p

  		end
	end

	def self.handle_example content
		@example = Example.new(:element_count => 0, :position => @topic.element_count, :topic_id => @topic.id, :name => content.to_s)
		@example.save!
		@topic.increment_element_count
	end

	def self.handle_sub_heading content
		@subHeading = SubHeading.new(:element_count => 0, :position => @topic.element_count, :topic_id => @topic.id, :name => content.to_s)
		@subHeading.save!
		@topic.increment_element_count
	end

	def self.handle_topic content
		@topic = Topic.new(:element_count => 0, :position => @chapter.element_count, :chapter_id => @chapter.id, :name => content.to_s)
		@topic.save!
		@chapter.increment_element_count

	end

	def self.handle_continuous_state_interrupt
		puts "handle_continuous_state_interrupt #{@states}"
		if @states[:indexInitiated]

			self.save_chapter_index
			@states[:indexInitiated] = false

		elsif @states[:imageInitiated]

			self.save_image
			@states[:imageInitiated] = false

		elsif @states[:quoteInitiated]

			self.save_quote
			@states[:quoteInitiated] = false

		elsif @states[:chemicalReactionInitiated]

			self.save_chemical_reaction
			@states[:chemicalReactionInitiated] = false

		elsif @states[:tableInitiated]

			self.save_table
			@states[:tableInitiated] = false

		end
	end

	def self.save_table
		if @states[:exampleInitiated]
			table = {:position => @example.element_count, :example_id => @example.id}
			@example.increment_element_count
		elsif @states[:subHeadingInitiated]
			table = {:position => @subHeading.element_count, :sub_heading_id => @subHeading.id}
			@subHeading.increment_element_count
		elsif @states[:topicInitiated]
			table = {:position => @topic.element_count, :topic_id => @topic.id}
			@topic.increment_element_count
		else
			table = {:position => @chapter.element_count, :chapter_id => @chapter.id}
			@chapter.increment_element_count
		end
		
		@table = Table.new(table)
		@table.save

		@image = Image.new(:name => @var[:table][:name], :table_id => @table.id)
		@image.save!
	end

	def self.save_chemical_reaction
		if @states[:exampleInitiated]
			chemical_reaction = {:position => @example.element_count, :example_id => @example.id, :description => @var[:chemicalReaction][:description]}
			@example.increment_element_count
		elsif @states[:subHeadingInitiated]
			chemical_reaction = {:position => @subHeading.element_count, :sub_heading_id => @subHeading.id, :description => @var[:chemicalReaction][:description]}
			@subHeading.increment_element_count
		elsif @states[:topicInitiated]
			chemical_reaction = {:position => @topic.element_count, :topic_id => @topic.id, :description => @var[:chemicalReaction][:description]}
			@topic.increment_element_count
		else
			chemical_reaction = {:position => @chapter.element_count, :chapter_id => @chapter.id, :description => @var[:chemicalReaction][:description]}
			@chapter.increment_element_count
		end
		
		@chemicalReaction = ChemicalReaction.new(chemical_reaction)
		@chemicalReaction.save

		@image = Image.new(:name => @var[:chemicalReaction][:name], :chemical_reaction_id => @chemicalReaction.id)
		@image.save!
	end

	def self.save_image
		if @states[:exampleInitiated]
			@var[:image].merge!(:position => @example.element_count, :example_id => @example.id)
			@example.increment_element_count
		elsif @states[:subHeadingInitiated]
			@var[:image].merge!(:position => @subHeading.element_count, :sub_heading_id => @subHeading.id)
			@subHeading.increment_element_count
		elsif @states[:topicInitiated]
			@var[:image].merge!(:position => @topic.element_count, :topic_id => @topic.id)
			@topic.increment_element_count
		else
			@var[:image].merge!(:position => @chapter.element_count, :chapter_id => @chapter.id)
			@chapter.increment_element_count
		end
		@image = Image.new(@var[:image])
		@image.save!
	end

	def self.save_paragraph content
		unless MathsHelper.is_empty? content
			puts "// PARAGRAPH".red
			if @states[:exampleInitiated]
				@paragraph = Paragraph.new(:content => content.to_s, :example_id => @example.id, :position => @example.element_count)
				@example.increment_element_count
			elsif @states[:subHeadingInitiated]
				@paragraph = Paragraph.new(:content => content.to_s, :sub_heading_id => @subHeading.id, :position => @subHeading.element_count)
				@subHeading.increment_element_count
			elsif @states[:topicInitiated]
				@paragraph = Paragraph.new(:content => content.to_s, :topic_id => @topic.id, :position => @topic.element_count)
				@topic.increment_element_count
			else
				@paragraph = Paragraph.new(:content => content.to_s, :chapter_id => @chapter.id, :position => @chapter.element_count)
				@chapter.increment_element_count
			end
			@paragraph.save!
		end
	end

	def self.save_quote
		if @states[:subHeadingInitiated]
			quote = Quote.new(:content => @var[:quote], :position => @subHeading.element_count, :sub_heading_id => @subHeading.id)
			@subHeading.increment_element_count
		elsif @states[:topicInitiated]
			quote = Quote.new(:content => @var[:quote], :position => @topic.element_count, :topic_id => @topic.id)
			@topic.increment_element_count
		else
			quote = Quote.new(:content => @var[:quote], :position => @chapter.element_count, :chapter_id => @chapter.id)
			@chapter.increment_element_count
		end
		quote.save!
	end

	def self.save_chapter_index
		@chapter_index = ChapterIndex.new(:content => @var[:chapterIndex], 
			:chapter_id => @chapter.id)
		@chapter_index.save!
	end

	def self.clean_database
		Chapter.delete_all
		ChapterIndex.delete_all
		Image.delete_all
	end
end