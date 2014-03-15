class Story
	include Mongoid::Document

	field :title
	field :default_character_id
	field :user_id
	
	belongs_to :user

	has_and_belongs_to_many :player_accounts

	has_many :scenes, inverse_of: :story
	accepts_nested_attributes_for :scenes, allow_destroy: true

	def characters
		characters = []
		scenes.each do |scene|
			characters << scene.character if scene.character_id.present?
		end
		characters
	end

	# The default character is used for the
	# story's initial 'confirm_start' email
	def default_character
		Character.find(default_character_id)
	end

end