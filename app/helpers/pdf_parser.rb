module PdfParser
	@indexInitNumber = 21

	@startIndexNumber = 21
	@endIndexNumber = 34
	@fileName = "Principles_of_Economics_6th.pdf"

	def self.init fileName = @fileName
		@reader = PDF::Reader.new(fileName)
		puts @reader.pdf_version
		# puts @reader.info
		# puts @reader.metadata
		puts @reader.page_count
		self.parsePages
	end

	def self.init_docsplit fileName = @fileName
		Docsplit.extract_text(fileName, {pdf_opts: '-raw',  
     		pages: @indexInitNumber..@indexInitNumber, 
     		output: 'tmp_text_file'})
	end

	def self.parsePages
		@reader.pages.each do |page|
			pageNumber = page.number
			puts "Writing Page Number #{pageNumber}".red
			PdfParser::ExtractImages.init page
			@pageHelper = PdfParser::PageHelper::Page.new page
			begin
				file = File.open("app/assets/book/text/#{pageNumber}", 'w')
				file.write @pageHelper.get_text 
			rescue IOError => e
			  	#some error occur, dir not writable etc.
			ensure
			  	file.close unless file.nil?
			end
		end
	end

	def self.handleIndex
		if pageNumber >= @startIndexNumber && pageNumber <= @endIndexNumber
			indexParser = PdfParser::IndexParser::Index.new @startIndexNumber, @endIndexNumber
		end
	end

end