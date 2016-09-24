class Topic < ActiveRecord::Base
	belongs_to :chapter
	has_one :heading, :class_name => "Heading"
	has_many :links, :class_name => "Link"
	has_many :tags, :class_name => "Tag"
	has_many :quotes, :class_name => "Quote"
	has_many :images, :class_name => "Image"
	has_many :tables, :class_name => "Table"
	has_many :paragraphs, :class_name => "Paragraph"
	has_many :chemical_reactions, :class_name => "ChemicalReaction"
	has_many :sub_headings, :class_name => "SubHeading"
	has_many :examples, :class_name => "Example"

	validates :name, :presence => true
	attr_accessible :element_count, :position, :chapter_id, :name, :links_updated

	def increment_element_count
		self.update(:element_count => self.element_count + 1)
	end

	def handle_tags
	end

	def handle_links
		begin
			RelatedLinksHelper.save_links_from_khan_academy(self.name, self.id)
			# self.update(:links_updated => true)
		rescue Exception => e
			puts "Error in saving #{e}".red
		end
	end

	def self.find_topic context
		context = context.downcase
		puts "#{context}".green
		topic = Topic.where("LOWER(name) LIKE (?)", "%#{context}%")[0]
		topic
	end

	def self.show_info_for context
		topic = self.find_topic context
		if topic
			info = {
				:name => topic.name,
				:id => topic.id,
				:chapter_id => topic.chapter.number,
				:element_count => topic.element_count,
				:paragraphs => topic.paragraphs.select(:id, :content, :position).map(&:attributes),
				:images => topic.images.select(:id, :name, :description, :position).map(&:attributes),
				:tables => topic.tables.select(:id, :content).map(&:attributes),
				:quotes => topic.quotes.select(:id, :content, :position).map(&:attributes),
				:chemical_reactions => ChemicalReaction.get_with_images_for_topic(topic.id),
				:sub_headings => SubHeading.get_all_for_topic(topic)
			}
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end

	def self.get_quotes context
		topic = self.find_topic context
		if topic
			info = topic.quotes.select(:id, :content).map(&:attributes)
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end

	def self.get_images context
		topic = self.find_topic context
		if topic
			info = topic.images.select(:id, :name, :description).map(&:attributes)
			info = {:images => info, :chapter_id => topic.chapter.number}
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end

	def self.get_chemical_reactions context
		topic = self.find_topic context
		if topic
			info = {:chemical_reactions => ChemicalReaction.get_with_images_for_topic(topic.id), :chapter_id => topic.chapter.number}
			# info = topic.chemical_reactions.select(:id, :image_id, :description)
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end

	def self.get_links context
		topic = self.find_topic context
		if topic
			info = topic.links.select(:id, :name, :url).map(&:attributes)
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end

	def self.get_questions context
		topic = self.find_topic context
		# info = topic.q
	end

	def self.get_examples context
		topic = self.find_topic context
		if topic
			examples = topic.examples
			info = []

			examples.each do |example|
				info.push({
					:id => example.id,
					:name => example.name,
					:chapter_id => topic.chapter.number,
					:element_count => example.element_count,
					:paragraphs => example.paragraphs.select(:id, :content, :position).map(&:attributes),
					:images => example.images.select(:id, :name, :description, :position).map(&:attributes),
					:tables => example.tables.select(:id, :content).map(&:attributes),
					:chemical_reactions => ChemicalReaction.get_with_images_for_example(example.id)
				})
			end
		else
			info = {"message": "Couldn't find this topic"}
		end
		info
	end
end