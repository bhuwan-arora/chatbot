module ChatbotHelper
	require 'wit'

	def self.init

		actions = {
		  	send: -> (request, response) {
		  		puts "REQUEST #{request} RESPONSE #{response}"
		    	puts("#{response['text']}")
		    	response
		  	},
		  	getHelp: -> (context){
		  		puts "CONTEXT #{context}".green
		  		data = {
		  			"help": ["Questions on X", "Links on X", "Chemical Reactions on X", "Quotes on X", "Images on X", "Examples on X"]
		  		}
	  		},
		  	getLinks: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"link": Topic.get_links(query)}
		  		data
	  		},
		  	getData: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"data": Topic.show_info_for(query)}
		  		data
		  	},
		  	getQuestions: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"question": Topic.get_questions(query)}
		  		data
		  	},
		  	getChemicalReactions: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"chemicalReaction": Topic.get_chemical_reactions(query)}
		  		data
	  		},
		  	getQuotes: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"quote": Topic.get_quotes(query)}
		  		data
		  	},
		  	getImages: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"images": Topic.get_images(query)}
		  		data
	  		},
		  	getExamples: -> (context){
		  		puts "CONTEXT #{context}".green
		  		query = context["entities"]["local_search_query"][0]["value"]
		  		data = {"example": Topic.get_examples(query)}
		  		data
	  		},
		}

		@client = Wit.new(access_token: "6YU3PLDK563ENS4SL5LU3EHEQQC6PGQL", actions: actions)

	end

	def self.query q
		begin
			self.init
			response = self.get_response q, {}
		rescue SocketError
			response = {"message": "SocketError"}
		end
		response
	end

	def self.get_response q, context
		session = 'my-user-session-42'
		# response = @client.converse("session_id", q, {})
		# response = @client.message(q)
		context  = @client.run_actions(session, q, context)
		context
	end



	def self.interact
		self.init
		@client.interactive
	end
end
