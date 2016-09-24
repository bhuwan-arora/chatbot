module RelatedLinksHelper
	require 'nokogiri'
  	require 'open-uri'


	def self.save_links_from_khan_academy(context, topic_id)
	  	context = context.downcase.gsub(" ", "+") + "+khan+academy"
	  	url = "https://www.google.co.in/search?q=#{context}"
	  	begin
		  	doc = Nokogiri::HTML(open(url))
		  	link_count = 4
		  	doc.css('.r')[0..link_count].each do |item|
		  		name = item.content
		  		url = item.children[0].attr("href")
		  		@link = Link.new(:name => name, :url => "google.com"+url, :topic_id => topic_id)
		  		@link.save
		  	end
	  	rescue Exception => e
	  		puts "Error in fetching links from Google".red
	  	end
	end

	def self.save_links_for_all_topics
		Topic.all.each do |topic|
			topic.handle_links
		end
	end

	def self.test_zomato
		url = "https://www.zomato.com/ncr/best-new-restaurants"
		doc = Nokogiri::HTML(open(url))
		doc.css('.bold').each do |item|
			title = item.attr('title')
			puts title
	  	end
	end

	def self.download_images
		for number in 1..114
			numberString = ""
			if number < 10
				numberString = "00"+number.to_s
			elsif number < 100
				numberString = "0"+number.to_s
			else
				numberString = number.to_s
			end
			puts "#{numberString}".red
			begin

				url = "https://0.s3.envato.com/files/103877236/Screenshots/Se7en-Light-images/Se7en-Light-images.#{numberString}.jpg"
				File.open("#{numberString}.jpg", 'wb') do |fo|
				  	fo.write open(url).read
				end
			rescue Exception => e
				puts e.to_s
			end
		end
	end


end