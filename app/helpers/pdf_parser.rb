module PdfParser
	@indexInitNumber = 21

	def self.init fileName = "Principles_of_Economics_6th.pdf"
		@reader = PDF::Reader.new(fileName)
		puts @reader.pdf_version
		# puts @reader.info
		# puts @reader.metadata
		puts @reader.page_count
		self.parsePages
	end

	def self.init_docsplit fileName = "Principles_of_Economics_6th.pdf"
		Docsplit.extract_text(fileName, {pdf_opts: '-raw',  
     		pages: @indexInitNumber..@indexInitNumber, 
     		output: 'tmp_text_file'})
	end

	def self.parsePages
		@reader.pages.each do |page, index|
			if page.number == @indexInitNumber
				@pageHelper = PdfParser::PageHelper::Page.new page
				objects = @pageHelper.get_objects
				debugger
				# pageHelper = PdfParser::ExtractImages.init page
				# debugger
				break
			end
		end
	end

end