class ChemicalReaction < ActiveRecord::Base
	belongs_to :topic
	belongs_to :chapter
	has_one :image
	belongs_to :sub_heading
	belongs_to :example
	attr_accessible :description, :topic_id, :position, :chapter_id, :sub_heading_id, :example_id


	def self.get_with_images_for_topic topic_id
		ChemicalReaction.left_join_images.where("chemical_reactions.topic_id" => topic_id).select("chemical_reactions.*, images.name")
	end

	def self.get_with_images_for_example example_id
		ChemicalReaction.left_join_images.where("chemical_reactions.example_id" => example_id).select("chemical_reactions.*, images.name")
	end

	def self.get_with_images_for_sub_heading sub_heading_id
		ChemicalReaction.left_join_images.where("chemical_reactions.sub_heading_id" => sub_heading_id).select("chemical_reactions.*, images.name")
	end

	private
	def self.left_join_images
		ChemicalReaction.joins("LEFT JOIN `images` ON images.id = chemical_reactions.image_id")
	end

end