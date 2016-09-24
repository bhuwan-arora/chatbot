module MathsHelper

	def self.is_empty? params
		is_empty = true
		if params.to_s.strip != "" && params.to_s.present?
			is_empty = false
		end
		is_empty
	end

	def self.normalise_string string
		string = string.to_s
				.gsub("//", "")
				.gsub(" ", "")
				.gsub("-", "")
				.strip.downcase
		string
	end

	def self.normalise_query_string string
		string = string.to_s
				.gsub("//", "")
				.strip.downcase
		string
	end

end