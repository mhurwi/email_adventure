class Scene
	include Mongoid::Document

	field :subject
	field :body
	field :preceding_scene_id
	field :character_id

	belongs_to :story

	embeds_many :choices
	accepts_nested_attributes_for :choices, allow_destroy: true

	def beginning?
		self.preceding_scene_id.blank?
	end

	def final?
		self.choices.count == 0
	end

	def preceding_scene
		Scene.find(self.preceding_scene_id)
	end

	def preceding_choice
		self.preceding_scene.choices.where(target_scene_id: self.id.to_s).first
	end


	def next_possible_scenes
		if not self.final?
			self.choices.map do |choice|
				choice.target_scene
			end
		end
	end

	def character
		Character.find(self.character_id)
	end

	def assign_character(character)
		self.update_attributes(character_id: character.id.to_s)
	end
	

end