module PdfParser::PageHelper

	class Page
		def initialize page
			@page ||= page	
		end

		def print_info
			puts "Number: #{get_page_number}".red
			# puts "Fonts: #{get_fonts}".green
			# puts "Objects: #{get_objects}".red
			puts "Text: #{get_text}".blue
			# puts "Page Object: #{get_page_object}".blue
			# puts "Raw Content: #{get_raw_content}".green
		end

		def get_fonts
			@page.fonts
		end

		def get_page_number
			@page.number
		end

		def get_objects
			@page.objects
		end

		def inspect_objects
			get_objects.inspect
		end

		def get_text
			@page.text
		end

		def get_page_object
			@page.page_object
		end

		def get_raw_content
			@page.raw_content
		end

		def walk
			receiver = PdfParser::PageHelper::RedGreenBlue.new
			@page.walk(receiver)
		end
	end

	class RedGreenBlue
	  	def set_rgb_color_for_nonstroking(r, g, b)
	    	puts "R: #{r}, G: #{g}, B: #{b}"
	  	end
	end

end